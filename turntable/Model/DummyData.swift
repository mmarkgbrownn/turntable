//
//  DummyData.swift
//  turntable
//
//  Created by Mark Brown on 12/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class DummyData: Datasource {
    
    let queueItems = [
        QueueItem(track: Track(id: "fakeID", name: "Hurting (Gerd Janson Remix)", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "SG Lewis", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "AlunaGeorge", imageSmall: "", imageLarge: "")], runtime: 183000), session: Session() , order: 1),
        QueueItem(track: Track(id: "fakeID", name: "Your Love", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "Tom Misch", imageSmall: "", imageLarge: "")], runtime: 249000), session: Session(), order: 2),
        QueueItem(track: Track(id: "fakeID", name: "AGEN WIDA", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "Joyryde", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "Skrillex", imageSmall: "", imageLarge: "")], runtime: 191400), session: Session(), order: 3),
        QueueItem(track: Track(id: "fakeID", name: "Sicko Mode", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "Travis Scott", imageSmall: "", imageLarge: "")], runtime: 307800), session: Session(), order: 4),
        QueueItem(track: Track(id: "fakeID", name: "The Love", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "JaduHeart", imageSmall: "", imageLarge: "")], runtime: 270000), session: currentSession, order: 5)
    ]
    
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
        return [ResourceCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return queueItems[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return queueItems.count
    }
    
    let nowPlaying = QueueItem(track: Track(id: "fakeID", name: "I'm A Kid", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "Jadu Heart", imageSmall: "", imageLarge: "")], runtime: 183000), session: Session(), order: 0)
}
