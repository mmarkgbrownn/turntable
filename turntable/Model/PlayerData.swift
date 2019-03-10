//
//  DummyData.swift
//  turntable
//
//  Created by Mark Brown on 12/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class PlayerData: Datasource {
    
//    func updatePlayerDataWith(track: String) {
//        APIHandler.shared.getTrack(trackId: track) { (track) in
//            self.nowPlaying = track
//            DispatchQueue.main.async {
//                player?.collectionView.reloadData()
//            }
//        }
//    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [PlayerMediaView.self, SectionHeaderCell.self, SectionHeaderCell.self]
    }
    
    override func headerItem(_ section: Int) -> Any? {
        if section == 1 {
            return "Up Next"
        } else if section == 2 {
            return "History"
        }
        return Session.shared().nowPlayingTrack
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        let cell = [SectionFooterCell.self]
        return cell
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [PlayerMetaData.self, QueueItemCell.self, QueueItemCell.self]
    }
    
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
