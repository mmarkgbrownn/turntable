//
//  DummyData.swift
//  turntable
//
//  Created by Mark Brown on 12/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class PlayerData: Datasource {
    
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
