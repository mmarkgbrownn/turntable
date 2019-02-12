//
//  DummyData.swift
//  turntable
//
//  Created by Mark Brown on 12/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class PlayerData: Datasource {
    
//    let track1 = Track(id: "", name: "Hurting (Gerd Janson Remix)", imageSmall: "830644e676708a8f628cdba9c8bae020b273994b", imageLarge: "85de4509b280464293ed51e1bf230b4a8c24962f", artist: [Artist(id: "fakeID", name: "SG Lewis", imageSmall: "", imageLarge: "")], runtime: 246468)
//    
//    let track2 = Track(id: "fakeID", name: "AGEN WIDA", imageSmall: "349edd37b55a1d2afb40ee79a3be1b0f822028b8", imageLarge: "8948d645353a40ad22bc5b9f62b955a26e3c66f1", artist: [Artist(id: "fakeID", name: "Joyryde", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "Skrillex", imageSmall: "", imageLarge: "")], runtime: 191400)
//    
//    let track3 = Track(id: "fakeID", name: "Sicko Mode", imageSmall: "092f661e5290a05410f1696e608cb140461b7ebf", imageLarge: "1ab97df000596d224199bbf7492e2bb5d09ea297", artist: [Artist(id: "fakeID", name: "Travis Scott", imageSmall: "", imageLarge: "")], runtime: 307800)
//    
//    let track4 = Track(id: "fakeID", name: "The Love", imageSmall: "9abaf059f3e703559057162a9b83729db1d3e24c", imageLarge: "7389b7b15bc74400ef7ac4ae73caa90011f98002", artist: [Artist(id: "fakeID", name: "JaduHeart", imageSmall: "", imageLarge: "")], runtime: "2:60")
    
//    lazy var queueItems = [
//
//        QueueItem(track: track2, timestamp: Int(NSTimeIntervalSince1970)),
//        QueueItem(track: track3, timestamp: Int(NSTimeIntervalSince1970)),
//        QueueItem(track: track1, timestamp: Int(NSTimeIntervalSince1970)),
//
//    ]
    
    lazy var nowPlaying = QueueItem()
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [SectionHeaderCell.self]
    }
    
    override func headerItem(_ section: Int) -> Any? {
        if section == 1 {
            return "History"
        }
        return "Up Next"
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        let cell = [SectionFooterCell.self]
        return cell
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [QueueItemCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return SessionQueue.shared().sessionQueue?[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        guard let queueCount = SessionQueue.shared().sessionQueue?.count else { return 0 }
        return queueCount
    }
}
