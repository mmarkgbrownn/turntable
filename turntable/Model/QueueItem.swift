//
//  QueueItem.swift
//  turntable
//
//  Created by Mark Brown on 10/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class QueueItem: Track {
    
    // Extra attributes required for queue items.
    var timestamp: Int?
    var wasPlayed: Bool?
    
    override init(){
        super.init()
    }
    
    fileprivate func extractedFunc(_ dictonary: [String : Any]) {
        self.timestamp = dictonary["timestamp"] as? Int
        self.wasPlayed = dictonary["wasPlayed"] as? Bool ?? false
    }
    
    // Dictionary initiliser
    override init(dictonary: [String: Any]) {
        super.init(id: dictonary["id"] as! String, name: dictonary["name"] as! String, spotifyURL: (dictonary["spotifyURL"] as! String), imageSmall: (dictonary["imageSmall"] as! String), imageLarge: (dictonary["imageLarge"] as! String), artist: dictonary["artist"] as! String, runtime: (dictonary["runtime"] as! String))
        extractedFunc(dictonary)
    }
    
    // Converts track to queue item for displaying in player/history, would ideally like a better solution that this.
    // Player current uses Track objects only.
    func convertTrackToQueueItem(track: Track, timestamp: Int, wasPlayed: Bool) -> QueueItem {
        self.id = track.id
        self.name = track.name
        self.spotifyURL = track.spotifyURL
        self.imageSmall = track.imageSmall
        self.imageLarge = track.imageLarge
        self.artist = track.artist
        self.runtime = track.runtime
        self.timestamp = timestamp
        self.wasPlayed = wasPlayed
        
        return self
    }
    
}
