//
//  MagicLinkView.swift
//  turntable
//
//  Created by Mark Brown on 16/10/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class MagicLinkView: BaseView {
    
    open var email: String? {
        didSet {
            guard let email = email else { return }
            instructionLabel.text = "To confirm your identity we sent a magic link to \(email). Please follow the steps in the email to continue"
        }
    }
    
    let reuseableComponents = ReusableComponents()
    
    let instructionLabel: UITextView = {
        let tv = UITextView()
        tv.textColor = .white
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.translatesAutoresizingMaskIntoConstraints = true
        tv.sizeToFit()
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    lazy var openButton = reuseableComponents.createButtonWith(label: "Open Mail App")
    lazy var resendButton = reuseableComponents.createSecondaryButtonWith(label: "I didnt get my mail")
    
    override func setupView() {
        super.setupView()
        
        let views = [instructionLabel, openButton, resendButton]
        
        views.forEach { addSubview($0) }
        
        instructionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 16, bottom: 0, right: 16))
        resendButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 34, right: 16), size: .init(width: 0, height: 55))
        openButton.anchor(top: nil, leading: leadingAnchor, bottom: resendButton.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16), size: .init(width: 0, height: 55))
    }
    
}
