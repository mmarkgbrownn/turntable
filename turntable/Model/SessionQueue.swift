//
//  SessionQueue.swift
//  turntable
//
//  Created by Mark Brown on 08/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

let currentSessionQueue = SessionQueue()

class SessionQueue {
    
    var session: Session?
    var sessionQueue: [QueueItem]?
    
    func setSession(session: Session) {
        self.session = session
        self.sessionQueue = []
    }
    
    func addToQueue(track: Track, completion: (Bool) -> ()) {
        
        //Add to firebase queue too
        if let sessionKey = currentSession.sessionKey, let trackId = track.id {
            
//            var artistValues = [String: String]()
//            track.artist?.forEach({ if let artistId = $0.id { artistValues[artistId] = "" } })
            
            let trackArtist = track.artist?.first?.name
            
            let sessionQueueDatabase = Database.database().reference().child("sessionQueue").child(sessionKey).child(trackId)
            let values = ["name": track.name, "artist": trackArtist, "imageSmall": track.imageSmall, "imageLarge": track.imageLarge, "runtime": track.runtime, "timestamp": String(NSTimeIntervalSince1970)]
            
            sessionQueueDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
                
                return
            })
    
            
        }
        
        let newItem = QueueItem(track: track, timestamp: Int(NSTimeIntervalSince1970))
        self.sessionQueue?.append(newItem)
        
        completion(true)
    }
    
    func getQueueFromFirebase() {
        
    }
    
}
