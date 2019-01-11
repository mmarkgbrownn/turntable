//
//  QueueItem.swift
//  turntable
//
//  Created by Mark Brown on 10/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class QueueItem: NSObject{
    
    var track: Track?
    var session: Session?
    var order: Int?
    var played = false
    
    init(track: Track, session: Session, order: Int) {
        self.track = track
        self.session = session
        self.order = order
    }
    
}
