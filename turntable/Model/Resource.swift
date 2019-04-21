//
//  Resource.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

// Resource superclass. Contains all basic details about a resorce.
class Resource: NSObject {
    
    var id: String?
    var name: String?
    var spotifyURL: String?
    var imageSmall: String?
    var imageLarge: String?
    
    override init() {
    }
    
    init(id: String, name: String, spotifyURL: String?, imageSmall: String?, imageLarge: String?) {
        self.id = id
        self.name = name
        if let imageSmall = imageSmall, let imageLarge = imageLarge, let spotifyURL = spotifyURL {
            self.imageSmall = imageSmall
            self.imageLarge = imageLarge
            self.spotifyURL = spotifyURL
        }
    }

} 

// Resrouce subclass used for all the track resources.
class Track: Resource {
    
    var artist: String?
    var runtime: String?
    
    override init(){
        super.init()
    }
    
    // Setter with raw track data
    init(id: String, name: String, spotifyURL: String?, imageSmall: String?, imageLarge: String?, artist: String, runtime: String?) {
        super.init(id: id, name: name, spotifyURL: spotifyURL, imageSmall: imageSmall, imageLarge: imageLarge)
        self.artist = artist
        self.runtime = runtime
    }
    
    // Setter using dictonary
    init(dictonary: [String: Any]) {
        super.init(id: dictonary["id"] as! String, name: dictonary["name"] as! String, spotifyURL: (dictonary["spotifyURL"] as! String), imageSmall: (dictonary["imageSmall"] as! String), imageLarge: (dictonary["imageLarge"] as! String))
        self.artist = (dictonary["artist"] as! String)
        self.runtime = (dictonary["runtime"] as! String)
    }
    
}

// Resource subclass for Artists, currently not used but is a starting point for future work.
class Artist: Resource {
    override init(id: String, name: String, spotifyURL: String?, imageSmall: String?, imageLarge: String?) {
        super.init(id: id, name: name, spotifyURL: spotifyURL, imageSmall: imageSmall, imageLarge: imageLarge)
    }
}
