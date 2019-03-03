//
//  SessionQueue.swift
//  turntable
//
//  Created by Mark Brown on 08/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

class SessionQueue {
    
    var session: Session?
    var sessionQueue: [QueueItem]?
    
    private static var currentSessionQueue: SessionQueue = {
        
        let sessionQueue = SessionQueue()
        return sessionQueue
        
    }()
    
    private init() {
    }
    
    class func shared() -> SessionQueue {
        return currentSessionQueue
    }
    
    func setSession(session: Session) {
        self.session = session
        self.sessionQueue = []
        self.observeQueue()
    }
    
    func addToQueue(track: Track, completion: (Bool) -> ()) {
        
        //Add to firebase queue too
        if let sessionKey = Session.shared().sessionKey, let trackId = track.id, let trackArtist = track.artist{
            
//            var artistValues = [String: String]()
//            track.artist?.forEach({ if let artistId = $0.id { artistValues[artistId] = "" } }
            
            let sessionQueueDatabase = Database.database().reference().child("sessionQueue").child(sessionKey).child(trackId)
            let values = ["id": trackId, "name": track.name, "artist": trackArtist, "imageSmall": track.imageSmall, "imageLarge": track.imageLarge, "runtime": track.runtime, "timestamp": String(NSTimeIntervalSince1970)] as [String: AnyObject]
            
            sessionQueueDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil { print(err!); return }
                
                return
            })
            
        }
        
        completion(true)
    }
    func playNextInQueue() {
        
        if let sessionQueue = self.sessionQueue, let sessionKey = self.session?.sessionKey {
            if sessionQueue.indices.contains(0) {
                guard let nextInQueue = SessionQueue.shared().sessionQueue?[0].id else { return }

                let sessionDatabase = Database.database().reference().child("session").child(sessionKey)
                let sessionQueueDatabase = Database.database().reference().child("sessionQueue").child(sessionKey).child(nextInQueue)

                sessionDatabase.updateChildValues(["nowPlaying" : nextInQueue], withCompletionBlock: { (error, ref) in
                    if error != nil { print(error!); return }
                    SessionQueue.shared().sessionQueue?.removeFirst()
                    sessionQueueDatabase.removeValue()
                    DispatchQueue.main.async {
                        player?.collectionView.reloadData()
                    }
                    
                })

            }
        }
    }
    
    func observeQueue()  {
        
        guard let sessionKey = Session.shared().sessionKey else { return }
        
        let sessionQueueDatabase = Database.database().reference().child("sessionQueue").child(sessionKey)
        sessionQueueDatabase.observe(.childAdded, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let queueItem = QueueItem(dictonary: dictionary)
            self.sessionQueue?.append(queueItem)
            
            DispatchQueue.main.async {
                player?.collectionView.reloadData()
            }
        })
        
    }
    
}
