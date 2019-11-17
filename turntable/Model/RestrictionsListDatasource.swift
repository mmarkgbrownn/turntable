//
//  RestrictionsListDatasource.swift
//  turntable
//
//  Created by Mark Brown on 17/11/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class RestrictionsListDatasource: NSObject, UICollectionViewDataSource {
    
    let headerPro = "With your Spotify free account you can still:"
    let headerCon = "You won't be able to:"
    
    let reasonA = RestrictionsListCellItem(text: "Join a session", type: .pro)
    let reasonB = RestrictionsListCellItem(text: "See whats playing", type: .pro)
    let reasonC = RestrictionsListCellItem(text: "Search for songs", type: .pro)
    let reasonD = RestrictionsListCellItem(text: "Queue Music", type: .pro)
    let reasonE = RestrictionsListCellItem(text: "Save the history playlist", type: .pro)
    
    let reasonF = RestrictionsListCellItem(text: "Host a session", type: .con)
    let reasonG = RestrictionsListCellItem(text: "Play or controll music in a session you have already hosted", type: .con)
    
    lazy var headers = [headerPro, headerCon]
    lazy var pros = [reasonA, reasonB, reasonC, reasonD, reasonE]
    lazy var cons = [reasonF, reasonG]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let returnValue: Int?
        switch section {
        case 0:
            returnValue = pros.count
        case 1:
            returnValue = cons.count
        default:
            returnValue = 0
        }
        return returnValue!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountCellId", for: indexPath) as? AccountRestirctionListCell
        
        switch indexPath.section {
        case 0:
            cell?.item = pros[indexPath.row]
        case 1:
            cell?.item = cons[indexPath.row]
        default:
            break
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! AccountRestirctionListHeader
            headerView.title = headers[indexPath.section]
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
}

enum RestrictionType {
    case pro
    case con
}

class RestrictionsListCellItem: NSObject {
    
    var itemText: String
    var itemType: RestrictionType
    
    init(text: String, type: RestrictionType) {
        self.itemText = text
        self.itemType = type
    }
    
}
