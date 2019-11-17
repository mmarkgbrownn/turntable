//
//  AccountRestrictionController.swift
//  turntable
//
//  Created by Mark Brown on 17/11/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import LBTAComponents

class AccountRestrictionController: UIViewController, UICollectionViewDelegate {
    
    let restrictionView = AccountRestrictionNotificationView()
    let listDatasource = RestrictionsListDatasource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "oops!"
        
        view.addSubview(restrictionView)
        restrictionView.fillSuperview()
        
        restrictionView.listCollectionView.delegate = self
        restrictionView.listCollectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        restrictionView.listCollectionView.dataSource = listDatasource
        
        restrictionView.listCollectionView.register(AccountRestirctionListCell.self, forCellWithReuseIdentifier: "accountCellId")
        restrictionView.listCollectionView.register(AccountRestirctionListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}

extension AccountRestrictionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.restrictionView.listCollectionView.bounds.width, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 40.0)
    }
}
