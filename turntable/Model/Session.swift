//
//  Session.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import Foundation

class Session: NSObject {
    
    let sessionCode: Int
    let sessionName: String
    var maxGuests: Int
    var context: String
    let historyPlaylist: String
    let organiser: Attendee
    
    
    init(sessionCode: Int, sessionName: String, maxGuests: Int, context: String, historyPlaylist: String, organiser: Attendee){
        self.sessionCode = sessionCode
        self.sessionName = sessionName
        self.maxGuests = maxGuests
        self.context = context
        self.historyPlaylist = historyPlaylist
        self.organiser = organiser
    }
        
}


