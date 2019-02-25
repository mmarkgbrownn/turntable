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

extension UIFont {
    class var poppinsPosterText: UIFont {
        return UIFont(name: "Poppins-Bold", size: 45.0)!
    }
    
    class var poppinsSectionHeader: UIFont {
        return UIFont(name: "Poppins-Bold", size: 31.0)!
    }
    
    class var poppinsPlayerHeader: UIFont {
        return UIFont(name: "Poppins-Bold", size: 21.0)!
    }
    
    class var poppinsSmallBold: UIFont {
        return UIFont(name: "Poppins-Bold", size: 14.0)!
    }
}

extension UIView {
    
    //      Example usage
    //      let someView = UIView()
    //      someView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom:             view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 100, height: 100))
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        //Set top, left, bottom and right constraints
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        //Set size contraints
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictronary = [String : UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictronary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictronary))
        
    }
}

extension CALayer {
    
    func applyShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        
        //Setup Shadow Properies
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        
        //Set Shadow
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
}

extension Notification.Name {
    struct Spotify {
        static let authURLOpened = Notification.Name("authURLOpended")
    }
}
