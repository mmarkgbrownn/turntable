//
//  SessionSetupView.swift
//  turntable
//
//  Created by Mark Brown on 15/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SessionSetupView: BaseView {
    
    let sessionCodeInput: UILabel = {
        let textField = UILabel()
        textField.textColor = .white
        textField.text = "6 5 4   0 9 6"
        textField.textAlignment = .center
        textField.font = UIFont.poppinsPosterText
        //textField.placeholder = "######"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let orLable: UILabel = {
        let lable = UILabel()
        lable.text = "or"
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 18)
        lable.textColor = UIColor.init(white: 1, alpha: 0.7)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let hostSessionButton = ReusableComponents().createButtonWith(label: "Host Session")
    
    let buttonText = "Enter the 6 digit code provided by your host to join the session. Alternatively, you can host your own session by tapping 'host session'."
    lazy var joinSessionInstruction = ReusableComponents().createDescriptionWith(text: buttonText)

    override func setupView() {
        super.setupView()
        
        let views = [sessionCodeInput, orLable, hostSessionButton, joinSessionInstruction]
        views.forEach() { addSubview($0) }
        
        sessionCodeInput.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 96, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 50))
        orLable.anchor(top: sessionCodeInput.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        hostSessionButton.anchor(top: orLable.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 55))
        joinSessionInstruction.anchor(top: hostSessionButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 62))
    }
}
