//
//  Extentions.swift
//  turntable
//
//  Created by Mark Brown on 08/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

// Setup design language colours
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

// Setup design language fonts
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
    
    // Anchor extention simplifies the constraint layout setup and reduces alot of reused code.
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
    
    // Automatically sets all the elements anchors to fill the super view.
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    // Used for visual contrainst format
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
    
    // Sets the shadow on all elements which use shadow. Maintains a visual consistency and easy editiablility.
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

extension String {
    public func isValidEmail() -> Bool {
        var validStatus = false
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        if emailPredicate.evaluate(with: self){
            validStatus = true
        }
        return validStatus
    }
}

// Setup notification for spotify auth, return from app.
extension Notification.Name {
    struct Spotify {
        static let authURLOpened = Notification.Name("authURLOpended")
    }
    struct Turntable {
        static let authURLOpened = Notification.Name("turntableAuthURLOpended")
    }
}
