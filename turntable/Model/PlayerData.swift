//
//  DummyData.swift
//  turntable
//
//  Created by Mark Brown on 12/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

// The datacource for the player, upnext and history.
class PlayerData: Datasource {
    
    // Sets the header classes for each section.
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [PlayerMediaView.self, SectionHeaderCell.self, SectionHeaderCell.self]
    }
    
    // Sets the header data for sections 2 & 3, these are used as titles. Also sets the now playing track for the first section.
    override func headerItem(_ section: Int) -> Any? {
        if section == 1 {
            return "Up Next"
        } else if section == 2 {
            return "History"
        }
        return Session.shared().nowPlayingTrack
    }
    
    // Set the footer classes
    override func footerClasses() -> [DatasourceCell.Type]? {
        let cell = [SectionFooterCell.self]
        return cell
    }
    
    // Sets the cell class for each section
    override func cellClasses() -> [DatasourceCell.Type] {
        return [PlayerMetaData.self, QueueItemCell.self, QueueItemCell.self]
    }
    
    // Indicates the data for each row of the table seperated by section
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0 {
            return Session.shared().nowPlayingTrack
        } else if indexPath.section == 1 {
            return SessionQueue.shared().sessionQueue?[indexPath.item]
        } else {
            return SessionQueue.shared().sessionHistory?[indexPath.item]
        }
    }
    
    override func numberOfSections() -> Int {
        return 3
    }
    
    // Defines the number of rows per section.
    override func numberOfItems(_ section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            guard let queueCount = SessionQueue.shared().sessionQueue?.count else { return 0 }
            return queueCount
        } else {
            guard let queueCount = SessionQueue.shared().sessionHistory?.count else { return 0 }
            return queueCount
        }
    }
}
