//
//  Attendee.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class Attendee: NSObject {

    let username: String
    let spotifyKey: String
    var currentSession: Session
    var history: Bool
    
    
    init(username: String, spotifyKey: String, currentSession: Session, history: Bool){
        self.username = username
        self.spotifyKey = spotifyKey
        self.currentSession = currentSession
        self.history = history
    }

}

class Guest: Attendee {
    
}

class Organiser: Attendee {
    
}
