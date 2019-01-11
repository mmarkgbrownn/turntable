//
//  SetupDummyData.swift
//  turntable
//
//  Created by Mark Brown on 10/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

func setupDummyData() {
    
    let artists = [
        Artist(id: "fakeID", name: "Travis Scott", imageSmall: "", imageLarge: ""),
        Artist(id: "fakeID", name: "SG Lewis", imageSmall: "", imageLarge: ""),
        Artist(id: "fakeID", name: "AlunaGeorge", imageSmall: "", imageLarge: ""),
        Artist(id: "fakeID", name: "Joyryde", imageSmall: "", imageLarge: ""),
        Artist(id: "fakeID", name: "Skrillex", imageSmall: "", imageLarge: ""),
        Artist(id: "fakeID", name: "Tom Misch", imageSmall: "", imageLarge: ""),
        Artist(id: "fakeID", name: "JaduHeart", imageSmall: "", imageLarge: ""),
    ]
    
    let tracks = [
        Track(id: "fakeID", name: "BUTTERFLY EFFECT", imageSmall: "", imageLarge: "", artist: [artists[0]], runtime: 310),
        Track(id: "fakeID", name: "Hurting (Gerd Janson Remix)", imageSmall: "", imageLarge: "", artist: [artists[1], artists[2]], runtime: 305),
        Track(id: "fakeID", name: "Your Love", imageSmall: "", imageLarge: "", artist: [artists[5]], runtime: 415),
        Track(id: "fakeID", name: "AGEN WIDA", imageSmall: "", imageLarge: "", artist: [artists[3], artists[4]], runtime: 319),
        Track(id: "fakeID", name: "Sicko Mode", imageSmall: "", imageLarge: "", artist: [artists[0]], runtime: 513),
        Track(id: "fakeID", name: "The Love", imageSmall: "", imageLarge: "", artist: [artists[6]], runtime: 450),
    ]
    
    let organiser = Attendee(username: "Markyb", spotifyKey: "token", history: true)
    
    let thisSession = Session(sessionCode: 345345, sessionName: "TestSession", maxGuests: 10, context: "Birthday Party", historyPlaylist: "fakePlayelist", organiser: organiser)

    
    let queueItems = [
        QueueItem(track: tracks[0], session: thisSession, order: 0),
        QueueItem(track: tracks[1], session: thisSession, order: 1),
        QueueItem(track: tracks[2], session: thisSession, order: 2),
        QueueItem(track: tracks[3], session: thisSession, order: 3),
        QueueItem(track: tracks[4], session: thisSession, order: 4),
        QueueItem(track: tracks[5], session: thisSession, order: 5)
    ]
    
    queueItems[0].played = true
    queueItems[4].played = true
    
    var upNextItems = [QueueItem]()
    var historyItems = [QueueItem]()
    
    for item in queueItems {
        if item.played == false{
            upNextItems.append(item)
        } else {
            historyItems.append(item)
        }
    }
    
    print("Up Next")
    print("------------")
    
    upNextItems.forEach { (item) in
        print(item.track!.name!)
        var artistString = ""
        item.track?.artist?.forEach({ (artist) in
            artistString = artistString + artist.name!
        })
        print(artistString)
    }
    print("------------")
    print("History")
    print("------------")
    
    historyItems.forEach { (item) in
        print(item.track!.name!)
        var artistString = ""
        item.track?.artist?.forEach({ (artist) in
            artistString = artistString + artist.name!
        })
        print(artistString)
    }
    
}
