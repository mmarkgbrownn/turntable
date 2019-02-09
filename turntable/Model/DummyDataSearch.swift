//
//  DummyDataSearch.swift
//  turntable
//
//  Created by Mark Brown on 08/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class DummyDataSearch: Datasource {
    
    let track1 = Track(id: "4CTQSJwlPQcwHbEBad0aXV", name: "Hurting (Gerd Janson Remix)", imageSmall: "830644e676708a8f628cdba9c8bae020b273994b", imageLarge: "85de4509b280464293ed51e1bf230b4a8c24962f", artist: [Artist(id: "fakeID", name: "SG Lewis", imageSmall: "", imageLarge: "")], runtime: 246468)
    
    let track2 = Track(id: "35V6qXUDCvwZdmbKe5PlPG", name: "AGEN WIDA", imageSmall: "349edd37b55a1d2afb40ee79a3be1b0f822028b8", imageLarge: "8948d645353a40ad22bc5b9f62b955a26e3c66f1", artist: [Artist(id: "fakeID", name: "Joyryde", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "Skrillex", imageSmall: "", imageLarge: "")], runtime: 191400)
    
    let track3 = Track(id: "2xLMifQCjDGFmkHkpNLD9h", name: "Sicko Mode", imageSmall: "092f661e5290a05410f1696e608cb140461b7ebf", imageLarge: "1ab97df000596d224199bbf7492e2bb5d09ea297", artist: [Artist(id: "fakeID", name: "Travis Scott", imageSmall: "", imageLarge: "")], runtime: 307800)
    
    let track4 = Track(id: "6vs7bTzYNAo4D5tDVjHmIB", name: "The Love", imageSmall: "9abaf059f3e703559057162a9b83729db1d3e24c", imageLarge: "7389b7b15bc74400ef7ac4ae73caa90011f98002", artist: [Artist(id: "fakeID", name: "JaduHeart", imageSmall: "", imageLarge: "")], runtime: 270000)
    
    let track5 = Track(id: "2G9GW71xBmdMxu3jJhnsx8", name: "Rhythm Of The Drum", imageSmall: "9e75f5a655770997a65a0b1c57a61aacc2fddaa8", imageLarge: "d3a44856cbc00e6070832cf3350b2cd3a2ee0b44", artist: [Artist(id: "fakeID", name: "Skift K3Y", imageSmall: "", imageLarge: "")], runtime: 270000)
    
    let track6 = Track(id: "7GL2SOvJXs8QVLX0cUADeq", name: "Count On You - ATFC's C-thru Remix", imageSmall: "432173382d9271fa8641cf59c9a0b01e4830b46f", imageLarge: "ea19ed3e663c7fb98ed2bf8dcf0641d9308bb40c", artist: [Artist(id: "fakeID", name: "Autoerotique", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "ATFC", imageSmall: "", imageLarge: "")], runtime: 270000)
    
    let track7 = Track(id: "63DQm30ycUr6xP2M1RUA57", name: "Suki", imageSmall: "d053700aec37d8ecdb33bcb01efabb8e7b025085", imageLarge: "66ab3b591869b58f8f7e778c0bb25d3166c0d5d3", artist: [Artist(id: "fakeID", name: "Black Loops", imageSmall: "", imageLarge: "")], runtime: 270000)
    
    let track8 = Track(id: "2GnA00tHtT8aUT2wyVdIde", name: "Drop That", imageSmall: "86912f3613a6e2fe305f369c7a4351c57b30e99c", imageLarge: "26a5226100f5e0a3340c56ba00084acba47379c7", artist: [Artist(id: "fakeID", name: "Loge21", imageSmall: "", imageLarge: "")], runtime: 241935)
    
    let track9 = Track(id: "3IVjcQvCFu1Bo7Kq3WRlNn", name: "Utopia", imageSmall: "19f684f448cd2131aa80119479a81c311ee50449", imageLarge: "8c52324daf4d038d93f72452b8018ad83f5edc1d", artist: [Artist(id: "fakeID", name: "Dombresky", imageSmall: "", imageLarge: "")], runtime: 270000)
    
    let track10 = Track(id: "4Pv7UF8K4Ja9PbnGVBFGA7", name: "E'z - Kyle Watson Remix", imageSmall: "e68c0d03ea56a1eff9f5f1511e03045f91f8d3ab", imageLarge: "fdac8cfea149a5a47806a14ba823616655892c90", artist: [Artist(id: "fakeID", name: "Black Loops", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "MAMA", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "Kyle Watson", imageSmall: "", imageLarge: "")], runtime: 270000)
    
    lazy var allTracks = [
        
        QueueItem(track: track1, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track2, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track3, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track4, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track5, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track6, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track7, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track8, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track9, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track10, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track6, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track7, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track8, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track9, timestamp: Int(NSTimeIntervalSince1970)),
        QueueItem(track: track10, timestamp: Int(NSTimeIntervalSince1970))
        
        
        ]
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ResourceCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [SectionHeaderCell.self]
    }
    
    override func headerItem(_ section: Int) -> Any? {
        return "Tracks"
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return allTracks[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return allTracks.count
    }
    
    func addItemToQueue(track: Track, completion: (Bool) -> ()) {
        
        let dummyData = DummyData()
        let newItem = QueueItem(track: track, timestamp: Int(NSTimeIntervalSince1970))
        dummyData.queueItems.append(newItem)
        print(dummyData.queueItems)
        
        completion(true)
    }
    
    
}
