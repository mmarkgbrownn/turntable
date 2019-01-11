//
//  Resource.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class Resource: NSObject {
    
    var id: String?
    var name: String?
    var imageSmall: String?
    var imageLarge: String?
    
    init(id: String, name: String, imageSmall: String, imageLarge: String) {
        self.id = id
        self.name = name
        self.imageSmall = imageSmall
        self.imageLarge = imageLarge
    }

}

class Track: Resource {
    
    var artist: Array<Artist>?
    var runtime: Int?
    
    init(id: String, name: String, imageSmall: String, imageLarge: String, artist: [Artist], runtime: Int) {
        super.init(id: id, name: name, imageSmall: imageSmall, imageLarge: imageLarge)
        self.artist = artist
        self.runtime = runtime
    }
    
}

class Artist: Resource {
    
    override init(id: String, name: String, imageSmall: String, imageLarge: String) {
        super.init(id: id, name: name, imageSmall: imageSmall, imageLarge: imageLarge)
    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
