//
//  ViewController.swift
//  turntable
//
//  Created by Mark Brown on 02/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class PlayerController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let redview = PlayerMediaView()
        //redview.backgroundColor = .red
        
        view.addSubview(redview)
        redview.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: view.frame.width, height: 528))
        
        view.backgroundColor = .backgroundDarkBlack
        
        let playerDataSource = DummyData()
        self.datasource = playerDataSource
        
        redview.nowPlaying = playerDataSource.nowPlaying
        
        collectionView.backgroundColor = nil
        collectionView.contentInset = UIEdgeInsets(top: 484, left: 0, bottom: 0, right: 0)
        view.bringSubviewToFront(collectionView)
    }

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
}

