//
//  Session.swift
//  turntable
//
//  Created by Mark Brown on 01/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

var currentSession = Session()

class Session {
    
    var sessionName: String?
    var sessionKey: String?
    var maxGuests: Int?
    var context: String?
    var historyPlaylist: String?
    var organiser: Attendee?
    
    let database = Database.database().reference(fromURL: "https://turntable-a0a6f.firebaseio.com/")
    
    init() {
    }
    
    func generateKey() {
        
        let keyNumbers  = 1...9
        let shuffledKey = keyNumbers.shuffled()
        let sessionKeyArray = shuffledKey.prefix(6)
        let sessionKey = sessionKeyArray.reduce(0){ $0 * 10 + $1 }
        
        self.sessionKey = String(sessionKey)
    
    }
    
    func createHistoryPlaylist(owner: Attendee) -> String {
        let historyPlaylist = "3Ms5s5BCv6oz8Xb0gVXti5"
        return historyPlaylist
    }
    
    func setupSession(sessionName: String, maxGuests: Int = 10, context: String, historyPlaylist: Bool, organiser: Attendee) -> Bool {
        
        self.sessionName = sessionName
        self.maxGuests = maxGuests
        self.context = context
        self.organiser = organiser
        
        currentSession.generateKey()
        
        if historyPlaylist {
            self.historyPlaylist = createHistoryPlaylist(owner: organiser)
        } else {
            self.historyPlaylist = ""
        }
        
        let sessionDatabase = database.child("session").child(self.sessionKey ?? "")
        let values = ["sessionName": sessionName, "owner": organiser.username!, "historyPlaylist": self.historyPlaylist!, "nowPlaying": "4N42f3TrE3gFSaEXPHr9Zp"]
        
        var success = true
            
        sessionDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                success = false
                return
            }
            return
        })

        return success
        
    }
    
    
}
