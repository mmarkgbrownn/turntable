//
//  LibraryController.swift
//  turntable
//
//  Created by Mark Brown on 07/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class SearchController: DatasourceController {
    
    let searchDataSource = DummyDataSearch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"
        
        view?.backgroundColor = .backgroundDarkBlack
        
        self.datasource = searchDataSource
        collectionView.backgroundColor = nil
    }
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.cellForItem(at: indexPath) as! SearchResultCell
//        
//        SessionQueue.shared().sessionQueue?.forEach({ (queueItem) in
//            if queueItem.id == cell.searchItem?.id {
//                print(cell.searchItem?.name, " is in queue")
//            } else {
//                
//            }
//        })
//        
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 16 + 48)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: view.frame.width, height: 100)
        }
        return .zero
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 16 + 48)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SearchResultCell
        cell?.didInteract(state: "highlight")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SearchResultCell
        cell?.didInteract(state: "unhighlight")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SearchResultCell
        if let track = cell?.searchItem {
            cell?.didInteract(state: "highlight")
            SessionQueue.shared().addToQueue(track: track) { (Bool) in
                cell?.itemStatusIndicator.image = UIImage(named: "inQueue")
                cell?.didInteract(state: "unhighlight")
            }
        }
    }
    
}
