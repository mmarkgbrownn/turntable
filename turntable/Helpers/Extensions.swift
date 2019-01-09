//
//  Extentions.swift
//  turntable
//
//  Created by Mark Brown on 08/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var backgroundDarkBlack: UIColor {
        return UIColor(white: 18.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var backgroundLightBlack: UIColor {
        return UIColor(white: 21.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var seaFoamBlue: UIColor {
        return UIColor(red: 110.0 / 255.0, green: 210.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
    }
}

extension UIView {
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
}
