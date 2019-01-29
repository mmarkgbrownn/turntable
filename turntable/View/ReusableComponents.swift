//
//  ReusableComponents.swift
//  turntable
//
//  Created by Mark Brown on 15/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class ReusableComponents: UIView {
    
    func createButtonWith(label: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .seaFoamBlue
        button.setTitle(label, for: .normal)
        button.titleLabel?.font = UIFont.poppinsPlayerHeader
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 13
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func createSeperatorWith(backgroundColor: UIColor = UIColor.init(white: 1, alpha: 0.2)) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }
    
    func createDescriptionWith(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(r: 109, g: 109, b: 114)
        label.backgroundColor = .clear
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
}
