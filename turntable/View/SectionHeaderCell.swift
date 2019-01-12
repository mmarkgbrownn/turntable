//
//  SectionHeaderCell.swift
//  turntable
//
//  Created by Mark Brown on 12/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SectionHeaderCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var header: String? {
        didSet {
            if let text = header {
                 headerText.text = text
            }
        }
    }
    
    let headerText: UILabel = {
        let label = UILabel()
        label.text = "Up"
        label.font = UIFont.poppinsPlayerHeader
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    func setupView() {
    
        addSubview(headerText)
        
        headerText.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
    }
}
