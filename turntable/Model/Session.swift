//
//  Session.swift
//  turntable
//
//  Created by Mark Brown on 01/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

class Session {
    
    var sessionName: String?
    var sessionKey: String?
    var maxGuests: Int?
    var context: String?
    var historyPlaylist: String?
    var organiser: String?
    var nowPlaying: String?
    
    private static var currentSession: Session = {
        
        let session = Session()
        return session
        
    }()
    
    private init() {
    }
    
    class func shared() -> Session {
        return currentSession
    }
    
    func generateKey() -> String {
        
        let keyNumbers  = 1...9
        let shuffledKey = keyNumbers.shuffled()
        let sessionKeyArray = shuffledKey.prefix(6)
        let sessionKey = sessionKeyArray.reduce(0){ $0 * 10 + $1 }
        
        return String(sessionKey)
    
    }
    
    func createHistoryPlaylist(owner: String) -> String {
        let historyPlaylist = "3Ms5s5BCv6oz8Xb0gVXti5"
        return historyPlaylist
    }
    
    func setupSession(sessionName: String, maxGuests: Int = 10, context: String, historyPlaylist: Bool, organiser: String) {
        
        let sessionKey = self.generateKey()
        
        if historyPlaylist {
            self.historyPlaylist = createHistoryPlaylist(owner: organiser)
        } else {
            self.historyPlaylist = ""
        }
        
        
        let sessionDatabase = Database.database().reference().child("session").child(sessionKey)
        let values = ["sessionKey": sessionKey, "sessionName": sessionName, "owner": organiser, "historyPlaylist": self.historyPlaylist!, "nowPlaying": "4N42f3TrE3gFSaEXPHr9Zp"]
            
        sessionDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil { print(err!); return }
            
            self.joinSession(snapshot: values, completion: { (Bool) in
                return
            })
            
            
        })
        
        self.sessionKey = sessionKey
        
    }
    
    func joinSession(snapshot: [String: Any], completion: (Bool) -> ()) {
        
        self.sessionKey = snapshot["sessionKey"] as? String
        self.sessionName = snapshot["sessionName"] as? String
        self.organiser = snapshot["owner"] as? String
        self.historyPlaylist = snapshot["historyPlaylist"] as? String
        self.nowPlaying = snapshot["nowPlaying"] as? String
        
        if let currentUserId = Attendee.shared().id, let sessionKey = self.sessionKey {
            let userDatabase = Database.database().reference().child("user").child(currentUserId)
            userDatabase.updateChildValues(["session": sessionKey])
        }
        
        Attendee.shared().session = sessionKey
        SessionQueue.shared().setSession(session: .currentSession)
        
        completion(true)

    }
    
    func leaveSession() {
        
        if self.organiser == Attendee.shared().id {
            guard let sessionKey = self.sessionKey else { return }
            
            let sessionDatabaseRef = Database.database().reference().child("session").child(sessionKey)
            let sessionQueueDatabaseRef = Database.database().reference().child("sessionQueue").child(sessionKey)
            
            sessionQueueDatabaseRef.removeAllObservers()
            sessionQueueDatabaseRef.removeValue()
            sessionDatabaseRef.removeValue()
        }
        
        Attendee.shared().clearSessionData()
        
        self.sessionKey = nil
        self.sessionName = nil
        self.organiser = nil
        self.historyPlaylist = nil
        self.nowPlaying = nil
        
    }
    
    func observeNowPlaying() {
        
        guard let sessionKey = Session.shared().sessionKey else { return }
        
        let sessionQueueDatabase = Database.database().reference().child("session").child(sessionKey)
        sessionQueueDatabase.observe(.value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            if let nowPlaying = dictionary["nowPlaying"] {
                self.nowPlaying = nowPlaying as? String
                player?.displayNewTrackInPlayer(trackId: nowPlaying as! String)
            }
        })
    }
    
    
}
