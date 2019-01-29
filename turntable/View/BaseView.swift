//
//  SetupSessionView.swift
//  turntable
//
//  Created by Mark Brown on 15/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }

}
