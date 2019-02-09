//
//  SessionSetupView.swift
//  turntable
//
//  Created by Mark Brown on 15/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SessionSetupView: BaseView , UITextFieldDelegate{
    
    let reusableComponents = ReusableComponents()
        
    lazy var numberInput: UITextField = {
        let input = UITextField()
        input.keyboardType = .decimalPad
        input.keyboardAppearance = .dark
        input.textAlignment = .center
        input.font = UIFont.poppinsPosterText
        input.textColor = .white
        input.delegate = self
        input.attributedPlaceholder = NSAttributedString(string: "000000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
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
    
    lazy var hostSessionButton = reusableComponents.createButtonWith(label: "Host Session")
    
    let buttonText = "Enter the 6 digit code provided by your host to join the session. Alternatively, you can host your own session by tapping 'host session'."
    
    lazy var joinSessionInstruction = reusableComponents.createDescriptionWith(text: buttonText)

    override func setupView() {
        super.setupView()
        
        let views = [numberInput, orLable, hostSessionButton, joinSessionInstruction]
        views.forEach() { addSubview($0) }
        
        numberInput.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 96, left: 40, bottom: 0, right: 40), size: .init(width: (40*6), height: 50))
        orLable.anchor(top: numberInput.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        hostSessionButton.anchor(top: orLable.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 55))
        joinSessionInstruction.anchor(top: hostSessionButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 62))
        
        numberInput.addTarget(self, action: #selector(joinSession), for: .editingChanged)
        
    }
    
    @objc func joinSession() {
        if numberInput.text!.count == 6 {
            textFieldDidEndEditing(numberInput)
            HostJoinSessionController().startJoiningSession(inputCode: numberInput.text!)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}
