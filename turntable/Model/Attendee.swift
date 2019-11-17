//
//  Attendee.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

class Attendee {

    //Referes to Firebase User ID.
    var id: String?
    // Referes to spotify ID.
    var sid: String?
    // Username is the Spotify users display name.
    var displayName: String?
    // User product is the type of user they are, their subscription level
    var product: String?
    // Spotify users email address.
    var email: String?
    // Used for suggestions.
    var birthdate: String?
    // The auth token given by Turntable server
    var accessToken: String?
    // Spotify users current tokens expiry date.
    var spotifySession: SPTSession?
    // Users current session.
    var session: String?
    // Spotify enrolment status in the history playlist.
    var history: Bool = false
    //The userDefaults refrence.
    let userDefaults = UserDefaults.standard
    
    // Singleton object setup.
    private static var currentUser: Attendee = {
        
        let session = Attendee()
        return session
        
    }()
    
    private init() {
    }
    
    class func shared() -> Attendee {
        return currentUser
    }
    
    // Set the user objects attributes and login to firebase.
    func setUser(userData: Any, completion: (Bool) -> ()) {
        
        // Sort through JSON data and set user details.
        if let dictionary = userData as? [String: Any] {
            if let id = dictionary["id"] as? String, let email = dictionary["email"] as? String, let displayName = dictionary["display_name"] as? String, let birthdate = dictionary["birthdate"] as? String, let product = dictionary["product"] as? String {
                self.sid = id
                self.email = email
                self.displayName = displayName
                self.birthdate = birthdate
                self.product = product
            } else { completion(false) }
        }
        
        // Returns a list of the login providers for a given email (e.g. facebook login, email etc).
        Auth.auth().fetchProviders(forEmail: self.email ?? "") { (result, error) in
            // If the user has a login provider then login, else register them as a new user.
            (result != nil) ? self.logUserIn() : self.registerNewUser()
        }
        
        completion(true)
        
    }
    
    func logUserIn() {
        // If these are set then attempt to sign in.
        if let email = self.email, let password = self.sid {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error != nil { print(error!); return }
                
                // Check the function returned user.
                if let userId = user?.user.uid {
                    // Find all stored user details and set the session and histroy playlist.
                    let userDatabase = Database.database().reference().child("user").child(userId)
                    // Update values to include all the user properties
                    userDatabase.observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let value = snapshot.value as? [String: AnyObject] else { return }
                        self.session = value["session"] as? String
                        self.history = value["historyPlaylist"] as? Bool ?? true
                        self.id = userId
                    })
                }
                return
            }
        }
    }

    
    func registerNewUser() {
        // If these exsist try the create user action.
        if let email = self.email, let password = self.sid, let displayName = self.displayName {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if error != nil { print(error!); return }
                
                // Check the function returns a user object.
                if let savedEmail = result?.user.email, let userId = result?.user.uid {
                    
                    let userDatabase = Database.database().reference().child("user").child(userId)
                    // Update values to include all the user properties.
                    let values = ["spotifyId": password, "displayName": displayName, "email": savedEmail, "bithdate": self.birthdate ?? "", "session": "", "historyPlaylist": self.history] as [AnyHashable : Any]
                    // Add values to user database
                    userDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
                        if err != nil { print(err!); return }
                        self.id = result?.user.uid
                        return
                    })
                }
            }
        }
    }
    
    // Stores all the current user details to user defaults.
    func storeUserDetails() {
        userDefaults.set(self.sid, forKey: "spotifyId")
        userDefaults.set(self.id, forKey: "userId")
        userDefaults.set(self.displayName, forKey: "displayName")
        userDefaults.set(self.email, forKey: "email")
        userDefaults.set(self.session, forKey: "session")
        let encodedSession: Data = NSKeyedArchiver.archivedData(withRootObject: self.spotifySession!)
        userDefaults.set(encodedSession, forKey: "spotifySession")
        userDefaults.set(self.session, forKey: "session")
        userDefaults.set(self.history, forKey: "history")
        
        userDefaults.synchronize()
    }
    
    // Loads all the current user details from user defaults.
    func loadUserFromUserDefaults() {
        self.sid = userDefaults.object(forKey: "spotifyId") as? String
        self.id = userDefaults.object(forKey: "userId") as? String
        self.displayName = userDefaults.object(forKey: "displayName") as? String
        self.email = userDefaults.object(forKey: "email") as? String
        self.session = userDefaults.object(forKey: "session") as? String
        self.history = userDefaults.object(forKey: "history") as? Bool ?? false
        
        if let decodedSession = userDefaults.object(forKey: "spotifySession") as? Data {
            self.spotifySession = NSKeyedUnarchiver.unarchiveObject(with: decodedSession) as? SPTSession
        }
    }
    
    // Remove all refrences to the current session.
    func clearSessionData() {
        
        if let currentUserId = self.id {
            let userDatabase = Database.database().reference().child("user").child(currentUserId)
            userDatabase.updateChildValues(["session": ""])
        }
        
        userDefaults.removeObject(forKey: "session")
        userDefaults.synchronize()
        
        Attendee.shared().session = nil
    }
    
    // Returns true if the current user is the session organiser.
    func isOrganiser() -> Bool {
        let result = (self.id == Session.shared().organiser) ? true : false
        return result
    }
    
    // Sets a new token using the token refresh service.
    func renewToken() {
        SPTAuth.defaultInstance().renewSession(spotifySession!, callback: { (error, session) in
            if session != nil {
                Attendee.shared().spotifySession = session
            }
        })
    }
    
    func initPlayer() {
        //Initalise player here
        //Called when playerview did load with an organiser
        if let userAccessToken = Attendee.shared().spotifySession?.accessToken {
            SPTAudioStreamingController.sharedInstance().login(withAccessToken: userAccessToken)
        }
    }

}
