//
//  DummyDataSearch.swift
//  turntable
//
//  Created by Mark Brown on 08/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class DummyDataSearch: Datasource {
    
    let searchResult1 = ["id": "4CTQSJwlPQcwHbEBad0aXV", "name": "Hurting (Gerd Janson Remix)", "artist": "SG Lewis, Aluna George, Gerd Janson", "imageSmall": "830644e676708a8f628cdba9c8bae020b273994b", "imageLarge": "85de4509b280464293ed51e1bf230b4a8c24962f", "runtime": "3:10", "timestamp": String(NSTimeIntervalSince1970)]
    let searchResult2 = ["id": "35V6qXUDCvwZdmbKe5PlPG", "name": "AGEN WIDA", "artist": "JOYRYDE", "imageSmall": "349edd37b55a1d2afb40ee79a3be1b0f822028b8", "imageLarge": "8948d645353a40ad22bc5b9f62b955a26e3c66f1", "runtime": "4:23", "timestamp": String(NSTimeIntervalSince1970)]
    let searchResult3 = ["id": "2xLMifQCjDGFmkHkpNLD9h", "name": "Sicko Mode", "artist": "Travis Scott", "imageSmall": "092f661e5290a05410f1696e608cb140461b7ebf", "imageLarge": "1ab97df000596d224199bbf7492e2bb5d09ea297", "runtime": "5:41", "timestamp": String(NSTimeIntervalSince1970)]
    let searchResult4 = ["id": "6vs7bTzYNAo4D5tDVjHmIB", "name": "The Love", "artist": "Jadu Heart", "imageSmall": "9abaf059f3e703559057162a9b83729db1d3e24c", "imageLarge": "7389b7b15bc74400ef7ac4ae73caa90011f98002", "runtime": "3:56", "timestamp": String(NSTimeIntervalSince1970)]
    let searchResult5 = ["id": "2G9GW71xBmdMxu3jJhnsx8", "name": "Rhythm Of The Drum", "artist": "Shift K3Y", "imageSmall": "9e75f5a655770997a65a0b1c57a61aacc2fddaa8", "imageLarge": "d3a44856cbc00e6070832cf3350b2cd3a2ee0b44", "runtime": "3:24", "timestamp": String(NSTimeIntervalSince1970)]
    let searchResult6 = ["id": "7GL2SOvJXs8QVLX0cUADeq", "name": "Count On You - ATFC's C-thru Remix", "artist": "Autoerotique", "imageSmall": "432173382d9271fa8641cf59c9a0b01e4830b46f", "imageLarge": "ea19ed3e663c7fb98ed2bf8dcf0641d9308bb40c", "runtime": "3:24", "timestamp": String(NSTimeIntervalSince1970)]
    let searchResult7 = ["id": "3IVjcQvCFu1Bo7Kq3WRlNn", "name": "Utopia", "artist": "Dombresky", "imageSmall": "19f684f448cd2131aa80119479a81c311ee50449", "imageLarge": "8c52324daf4d038d93f72452b8018ad83f5edc1d", "runtime": "3:24", "timestamp": String(NSTimeIntervalSince1970)]
    
    //lazy var searchTracks = [searchResult1, searchResult2, searchResult3, searchResult4, searchResult5, searchResult6, searchResult7]

    lazy var searchResults = [
        QueueItem(dictonary: searchResult1),
        QueueItem(dictonary: searchResult2),
        QueueItem(dictonary: searchResult3),
        QueueItem(dictonary: searchResult4),
        QueueItem(dictonary: searchResult5),
        QueueItem(dictonary: searchResult6),
        QueueItem(dictonary: searchResult7)
    ]

    override func cellClasses() -> [DatasourceCell.Type] {
        return [SearchResultCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [SectionHeaderCell.self]
    }
    
    override func headerItem(_ section: Int) -> Any? {
        return "Tracks"
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return searchResults[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return searchResults.count
    }
    
}
