//
//  QueueItem.swift
//  turntable
//
//  Created by Mark Brown on 10/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class QueueItem {
    
    var track: Track?
    var timestamp: Int?
    
    init(track: Track, timestamp: Int) {
        
        self.track = track
        self.timestamp = timestamp
        
    }
    
}
