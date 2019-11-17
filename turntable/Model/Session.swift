//
//  Session.swift
//  turntable
//
//  Created by Mark Brown on 01/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

// The main session object.
class Session {
    // Session details, name, code/id etc
    var sessionName: String?
    var sessionKey: String?
    // Set max guests, currently not used but could be implemented for a way of montisation.
    var maxGuests: Int?
    // Count the amount of tracks played in the session
    var tracksPlayed: Int = 0
    // Context, again, currently not used but could be implemented to make better suggestions.
    var context: String?
    // Ref to playlist for spotify
    var historyPlaylist: String?
    // The organisers id
    var organiser: String?
    // The ref of the now playing track
    var nowPlaying: String?
    // The now playing object
    var nowPlayingTrack: Track?
    
    private static var currentSession: Session = {
        
        let session = Session()
        return session
        
    }()
    
    private init() {
    }
    
    class func shared() -> Session {
        return currentSession
    }
    
    // Generates a key and returns it as a string, currently could create duplicate keys
    func generateKey() -> String {
        
        let keyNumbers  = 1...9
        let shuffledKey = keyNumbers.shuffled()
        let sessionKeyArray = shuffledKey.prefix(6)
        let sessionKey = sessionKeyArray.reduce(0){ $0 * 10 + $1 }
        
        return String(sessionKey)
    
    }
    
    // Setup a session, collect all the detail and prepare to be made in database.
    func setupSession(sessionName: String, maxGuests: Int = 10, context: String, historyPlaylist: Bool, organiser: String) {
        
        // Generate key
        let sessionKey = self.generateKey()
        // If history playlist is turned on then create a playlist
        if historyPlaylist {
            SpotifyAPIHandler.shared.createPlaylist(name: sessionName) { (playlistId) in
                // Set the history playlist of the session and the organiser.
                self.historyPlaylist = playlistId
                // Playlist creators are automatically following playlist.
                Attendee.shared().history = true
                self.createSessionInFirebase(sessionKey, sessionName, organiser)
            }
        } else {
            self.historyPlaylist = ""
            createSessionInFirebase(sessionKey, sessionName, organiser)
        }
        
        self.sessionKey = sessionKey
        
    }
    
    // Create a session object in firebase database.
    fileprivate func createSessionInFirebase(_ sessionKey: String, _ sessionName: String, _ organiser: String) {
        let sessionDatabase = Database.database().reference().child("session").child(sessionKey)
        let values = ["sessionKey": sessionKey, "sessionName": sessionName, "tracksPlayed": tracksPlayed, "owner": organiser, "historyPlaylist": self.historyPlaylist!, "nowPlaying": "4N42f3TrE3gFSaEXPHr9Zp"] as [String : Any]
        
        // Add values to database child of session key
        sessionDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil { print(err!); return }
            
            // Get track of the chosen now playing and add to the queue.
            SpotifyAPIHandler.shared.getTrack(trackId: values["nowPlaying"] as! String, completion: { (track) in
                self.nowPlayingTrack = track
                SessionQueue.shared().addToQueue(track: self.nowPlayingTrack!, completion: { (succ) in })
            })
            
            // Join the sesssion
            self.joinSession(snapshot: values, completion: { (Bool) in
                return
            })
            
            
        })
    }
    
    // Join session func for organisers and guests
    func joinSession(snapshot: [String: Any], completion: (Bool) -> ()) {
        // Set all the session details
        self.sessionKey = snapshot["sessionKey"] as? String
        self.sessionName = snapshot["sessionName"] as? String
        self.tracksPlayed = snapshot["tracksPlayed"] as! Int
        self.organiser = snapshot["owner"] as? String
        self.historyPlaylist = snapshot["historyPlaylist"] as? String
        self.nowPlaying = snapshot["nowPlaying"] as? String
        
        // Update the users firebase ref with the new session key.
        if let currentUserId = Attendee.shared().id, let sessionKey = self.sessionKey {
            let userDatabase = Database.database().reference().child("user").child(currentUserId)
            userDatabase.updateChildValues(["session": sessionKey])
        }
        
        // Set the users session code locally
        Attendee.shared().session = sessionKey
        // Set the sessionQueue to link with the session
        SessionQueue.shared().setSession(session: .currentSession)
        
        completion(true)

    }
    
    // Remove all the session refrences throughout the app and users database entry.
    func leaveSession() {
        
        
        if self.organiser == Attendee.shared().id {
            SPTAudioStreamingController.sharedInstance().logout()
        }
        
        // Remove all database observers.
        guard let sessionKey = self.sessionKey else { return }
        
        let sessionDatabaseRef = Database.database().reference().child("session").child(sessionKey)
        let sessionQueueDatabaseRef = Database.database().reference().child("sessionQueue").child(sessionKey)
        
        sessionDatabaseRef.removeAllObservers()
        sessionQueueDatabaseRef.removeAllObservers()
        
        // Clear data from the attendee object.
        Attendee.shared().clearSessionData()
        
        // Clear all of the session details in self.
        self.sessionKey = nil
        self.sessionName = nil
        self.organiser = nil
        self.historyPlaylist = nil
        self.nowPlaying = nil
        
        // Set all refrences to session object to nil.
        SessionQueue.shared().sessionQueue = nil
        SessionQueue.shared().sessionHistory = nil
        SessionQueue.shared().session = nil
        
    }
    
    // Setup the now playing observer
    func observeNowPlaying() {
        // Use guard statement to safely check if session is set.
        guard let sessionKey = Session.shared().sessionKey else { return }
        
        // Setup firebase observer.
        let sessionQueueDatabase = Database.database().reference().child("session").child(sessionKey)
        sessionQueueDatabase.observe(.value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            // If the session queue isnt empty and there is a now playing track set, remove next in queue (as it becomes the now playing) and insert the last played song into the history.
            if !(SessionQueue.shared().sessionQueue!.isEmpty) && self.nowPlayingTrack != nil {
                let newHistroyObject = QueueItem().convertTrackToQueueItem(track: self.nowPlayingTrack!, timestamp: 0, wasPlayed: true)
                SessionQueue.shared().sessionQueue?.removeFirst()
                SessionQueue.shared().sessionHistory?.insert(newHistroyObject, at: 0)
            }
            
            // Set the now playing data and update the player UI
            if let nowPlaying = dictionary["nowPlaying"] {
                self.nowPlaying = nowPlaying as? String
                SpotifyAPIHandler.shared.getTrack(trackId: self.nowPlaying!, completion: { (track) in
                    self.nowPlayingTrack = track
                    DispatchQueue.main.async {
                        player?.play()
                        player?.collectionView.reloadData()
                    }
                    
                })
                
            }
            
        })
        
    }
    
    
}
