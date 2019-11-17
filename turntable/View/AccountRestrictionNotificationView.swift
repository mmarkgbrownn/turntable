//
//  AccountRestrictionNotificationView.swift
//  turntable
//
//  Created by Mark Brown on 17/11/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import LBTAComponents

class AccountRestrictionNotificationView: BaseView {
    
    let reusableComponents = ReusableComponents()
    
    let descriptionText = "You connected a Spotify free account. Unfortunatly to host sessions and play music you’ll need a Spotify Premium Account."
    let detailText = "With your Spotify free account you can still:"
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = descriptionText
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let listCollectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        return cv
    }()
    
    lazy var connectAnotherAccountButton =  reusableComponents.createButtonWith(label: "Connect Another Account")
    lazy var continueAnywayButton = reusableComponents.createSecondaryButtonWith(label: "Continue with Spotify Free")
    
    override func setupView() {
        super.setupView()
        
        let views = [descriptionLabel, listCollectionView, connectAnotherAccountButton, continueAnywayButton]
        
        views.forEach({ addSubview($0) })
        
        
        descriptionLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .zero)
        
        continueAnywayButton.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 32, right: 16), size: .init(width: 0, height: 56))
        connectAnotherAccountButton.anchor(top: nil, leading: continueAnywayButton.leadingAnchor, bottom: continueAnywayButton.topAnchor, trailing: continueAnywayButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 0, height: 56))
        
        listCollectionView.anchor(top: descriptionLabel.bottomAnchor, leading: descriptionLabel.leadingAnchor, bottom: connectAnotherAccountButton.topAnchor, trailing: descriptionLabel.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 32, right: 0), size: .zero)

    }
}

class AccountRestirctionListCell: UICollectionViewCell {
    
    var item: RestrictionsListCellItem? {
        didSet {
            if let item = item {
                self.listTextLabel.text = item.itemText
                
                switch item.itemType {
                case RestrictionType.pro:
                    self.listBulletPoint.backgroundColor = .seaFoamBlue
                case RestrictionType.con:
                    self.listBulletPoint.backgroundColor = .systemRed
                }
            }
        }
    }
    
    let listBulletPoint : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let listTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        let views = [listBulletPoint, listTextLabel]
        views.forEach({ addSubview($0) })
        
        listBulletPoint.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .zero, size: .init(width: 16, height: 16))
        listTextLabel.anchor(top: self.topAnchor, leading: listBulletPoint.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .zero)
        
    }
}

class AccountRestirctionListHeader:  UICollectionReusableView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String? {
        didSet {
            if let title = title {
                self.headerLabel.text = title
            }
        }
    }
    
    let headerLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    func setupViews() {
        addSubview(headerLabel)
        headerLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .zero)
    }
    
}
