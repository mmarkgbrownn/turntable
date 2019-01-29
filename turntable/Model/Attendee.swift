//
//  Attendee.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

struct Attendee {

    var username: String?
    var email: String?
    var spotifyKey: String?
    var history: Bool?
    
    init(){
        
    }
    
    init(username: String, email: String, spotifyKey: String, history: Bool){
        self.username = username
        self.email = email
        self.spotifyKey = spotifyKey
        self.history = history
    }

}
