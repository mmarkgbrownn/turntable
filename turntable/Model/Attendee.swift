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

    //Referes to Firebase User ID
    var id: String?
    // Referes to spotify ID
    var sid: String?
    // Username is the Spotify users display name
    var displayName: String?
    // Spotify users email address
    var email: String?
    // Used for suggestions
    var birthdate: String?
    // Spotify users current access token
    var accessToken: String?
    // Spotify users current tokens expiry date
    var expiryDate: Date?
    // Spotify users refresh token for when current expires
    var refreshToken: String?
    // Users current session
    var session: String?
    // Spotify enrolment status in the history playlist
    var history: Bool = true
    //The userDefaults refrence
    let userDefaults = UserDefaults.standard
    
    private static var currentUser: Attendee = {
        
        let session = Attendee()
        return session
        
    }()
    
    private init() {
    }
    
    class func shared() -> Attendee {
        return currentUser
    }
    
    func displayUserDetails() {
        print("id: ", self.id ?? " ", ", spotify id: ", self.sid ?? " ", ", display name: ", self.displayName ?? " ", ", email: ", self.email ?? " ", ", birthdate: ", self.birthdate ?? " ", ", access token: ", self.accessToken ?? " ", ", expiry date: ", self.expiryDate ?? " ", ", refresh token: ", self.refreshToken ?? " ", ", session: ", self.session ?? " ", ", history enabled: ", self.history)
    }
    
    // Set the user objects attributes and login to firebase.
    func setUser(userData: Any, completion: (Bool) -> ()) {
        
//        self.accessToken = AppDelegate.shared.sessionManager.session?.accessToken
//        self.expiryDate = AppDelegate.shared.sessionManager.session?.expirationDate
//        self.refreshToken = AppDelegate.shared.sessionManager.session?.refreshToken
        
        // Sort through JSON data
        if let dictionary = userData as? [String: Any] {
            if let id = dictionary["id"] as? String, let email = dictionary["email"] as? String, let displayName = dictionary["display_name"] as? String, let birthdate = dictionary["birthdate"] as? String {
                self.sid = id
                self.email = email
                self.displayName = displayName
                self.birthdate = birthdate
            }
        }
        
        Auth.auth().fetchProviders(forEmail: self.email ?? "") { (result, error) in
            (result == ["password"]) ? self.logUserIn() : self.registerNewUser()
        }
        
        completion(true)
        
    }
    
    func logUserIn() {
        if let email = self.email, let password = self.sid {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error != nil { print(error!); return }
                self.id = user?.user.uid
                self.storeUserDetails()
                return
            }
        }
    }

    func registerNewUser() {
        if let email = self.email, let password = self.sid, let displayName = self.displayName, let refreshToken = self.refreshToken, let birthdate = self.birthdate {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if error != nil { print(error!); return }
                
                if let savedEmail = result?.user.email, let userId = result?.user.uid {
                    
                    let userDatabase = Database.database().reference().child("user").child(userId)
                    // Update values to include all the user properties
                    let values = ["spotifyId": password, "displayName": displayName, "email": savedEmail, "bithdate": birthdate, "refreshToken": refreshToken , "session": "", "historyPlaylist": self.history] as [AnyHashable : Any]
                    
                    userDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
                        if err != nil { print(err!); return }
                        self.id = result?.user.uid
                        self.storeUserDetails()
                        return
                    })
                }
            }
        }
    }
    
    func storeUserDetails() {
        
        userDefaults.set(self.sid, forKey: "spotifyId")
        userDefaults.set(self.id, forKey: "userId")
        userDefaults.set(self.displayName, forKey: "displayName")
        userDefaults.set(self.email, forKey: "email")
        userDefaults.set(self.accessToken, forKey: "accessToken")
        userDefaults.set(self.expiryDate, forKey: "expiryDate")
        userDefaults.set(self.refreshToken, forKey: "refreshToken")
        userDefaults.set(self.session, forKey: "session")
        userDefaults.set(self.history, forKey: "history")
        
    }
    
    func loadUserFromUserDefaults() {
        
        self.sid = userDefaults.object(forKey: "spotifyId") as? String
        self.id = userDefaults.object(forKey: "userId") as? String
        self.displayName = userDefaults.object(forKey: "displayName") as? String
        self.email = userDefaults.object(forKey: "email") as? String
        self.accessToken = userDefaults.object(forKey: "accessToken") as? String
        self.expiryDate = userDefaults.object(forKey: "expiryDate") as? Date
        self.refreshToken = userDefaults.object(forKey: "refreshToken") as? String
        self.session = userDefaults.object(forKey: "session") as? String
        self.history = userDefaults.object(forKey: "history") as? Bool ?? false
        
        Attendee.shared().displayUserDetails()
    }
    
    func checkIfInSession(completion: @escaping (String) -> Void) {
        
        if let userId = Auth.auth().currentUser?.uid {
            let userDatabase = Database.database().reference().child("user").child(userId)
            userDatabase.observeSingleEvent(of: .value) { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                let sessionKey = value?["session"] as? String ?? ""
                
                if sessionKey != "" {
                    let sessionDatabase = Database.database().reference().child("session").child(sessionKey)
                    sessionDatabase.observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                        Session.shared().joinSession(snapshot: dictionary, completion: { (succ) in
                            completion("InSession")
                        })
                    })
                } else {
                    completion("NotInSession")
                }
                
                return
            }
        }
    }
    
    func setSession() {
        //Set the users current session
    }
    
    func logOut() {
        //Log user out, if user owns session call to kill session
    }
    
    func tokenHasExpired() -> Bool {
        //Check to see if token has expired by checking expiry date
        return false
    }
    
    func renewToken() {
        // Call if token has expired, renews the access token
    }
    
    func initPlayer() {
        //Initalise player here
        //Called when playerview did load
        if let userAccessToken = Attendee.shared().accessToken {
            SPTAudioStreamingController.sharedInstance().login(withAccessToken: userAccessToken)
        }
    }

}
