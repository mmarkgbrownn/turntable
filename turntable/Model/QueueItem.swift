//
//  QueueItem.swift
//  turntable
//
//  Created by Mark Brown on 10/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class QueueItem: Track {
    
//    var id: String?
//    var name: String?
//    var imageSmall: String?
//    var imageLarge: String?
//    var artist: String?
//    var runtime: String?
    var timestamp: String?
    
    override init(){
        super.init()
    }
    
    init(dictonary: [String: Any]) {
        super.init(id: dictonary["id"] as! String, name: dictonary["name"] as! String, imageSmall: (dictonary["imageSmall"] as! String), imageLarge: (dictonary["imageLarge"] as! String), artist: dictonary["artist"] as! String, runtime: (dictonary["runtime"] as! String))
        self.timestamp = dictonary["timestamp"] as? String
    }
    
}
