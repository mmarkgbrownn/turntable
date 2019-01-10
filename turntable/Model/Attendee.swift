//
//  Attendee.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class Attendee: NSObject {

    var username: String
    var spotifyKey: String
    var history: Bool
    
    
    init(username: String, spotifyKey: String, history: Bool){
        self.username = username
        self.spotifyKey = spotifyKey
        self.history = history
    }

}
