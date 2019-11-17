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
    // Class atrributes include the session the queue array and histroy array.
    var session: Session?
    var sessionQueue: [QueueItem]?
    var sessionHistory: [QueueItem]?
    
    private static var currentSessionQueue: SessionQueue = {
        
        let sessionQueue = SessionQueue()
        return sessionQueue
        
    }()
    
    private init() {
    }
    
    class func shared() -> SessionQueue {
        return currentSessionQueue
    }
    
    // Set the session
    func setSession(session: Session) {
        self.session = session
        self.sessionQueue = []
        self.sessionHistory = []
        self.observeQueue()
    }
    
    // Func to add the selected track to the session queue.
    func addToQueue(track: Track, completion: (Bool) -> ()) {
        //Add to firebase queue too
        if let sessionKey = Session.shared().sessionKey, let trackId = track.id, let trackArtist = track.artist, let spotifyURL = track.spotifyURL{
            
            let sessionQueueDatabase = Database.database().reference().child("sessionQueue").child(sessionKey).child(trackId)
            let timestamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
            let values = ["id": trackId, "name": track.name!, "artist": trackArtist, "spotifyURL": spotifyURL, "imageSmall": track.imageSmall!, "imageLarge": track.imageLarge!, "runtime": track.runtime!, "timestamp": timestamp, "wasPlayed": false] as [String: AnyObject]
            // Add values to database as a child of sessionKey.
            sessionQueueDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil { print(err!); return }
                return
            })
            
        }
        completion(true)
    }
    
    // Play the next song in the queue. This function is only called by the session organiser. As the observe now playing function handels adding a removing object from the up next to the player and into the history.
    func playNextInQueue() {
        
        if let sessionQueue = self.sessionQueue, let sessionKey = self.session?.sessionKey {
            if sessionQueue.indices.contains(0) {
                guard let nextInQueue = SessionQueue.shared().sessionQueue?[0].id else { return }

                let sessionDatabase = Database.database().reference().child("session").child(sessionKey)
                let sessionQueueDatabase = Database.database().reference().child("sessionQueue").child(sessionKey).child(Session.shared().nowPlaying!)
                // Tell the session that the track was played.
                sessionQueueDatabase.updateChildValues(["wasPlayed" : true])
                
                // Add the track to the spotify playlist and update the session details. (This will fire off observe now playing.)
                SpotifyAPIHandler.shared.addTrackToHistory(trackId: Session.shared().nowPlaying!)
                Session.shared().tracksPlayed += 1
                sessionDatabase.updateChildValues(["nowPlaying" : nextInQueue, "tracksPlayed" : Session.shared().tracksPlayed])
            }
        }
    }
    
    // Observe the queue for additions to the up next. Also runs when joining/opening the app when in a session
    func observeQueue()  {
        
        guard let sessionKey = Session.shared().sessionKey else { return }
        
        let sessionQueueDatabase = Database.database().reference().child("sessionQueue").child(sessionKey)
        sessionQueueDatabase.observe(.childAdded, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let queueItem = QueueItem(dictonary: dictionary)
            
            if queueItem.id == Session.shared().nowPlaying { return }
            
            // Sort throught the tracks and set them into either upnext or history
            if queueItem.wasPlayed == true {
                // Sort by timestamp for each track
                self.sessionHistory?.insert(queueItem, at: 0)
                self.sessionHistory?.sort(by: { (track1, track2) -> Bool in
                    guard let timestamp1 = track1.timestamp, let timestamp2 = track2.timestamp else {return false}
                    return timestamp1 > timestamp2
                })
            } else {
                // Sort by timestamp for each track
                self.sessionQueue?.append(queueItem)
                self.sessionQueue?.sort(by: { (track1, track2) -> Bool in
                    guard let timestamp1 = track1.timestamp, let timestamp2 = track2.timestamp else {return false}
                    return timestamp1 < timestamp2
                })
            }
            // Notify the UI to update.
            DispatchQueue.main.async {
                player?.collectionView.reloadData()
            }
        })
    }
}
