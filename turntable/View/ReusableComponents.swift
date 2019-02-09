//
//  ReusableComponents.swift
//  turntable
//
//  Created by Mark Brown on 15/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class ReusableComponents: UIView, UITextFieldDelegate {
    
    func createButtonWith(label: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .seaFoamBlue
        button.setTitle(label, for: .normal)
        button.titleLabel?.font = UIFont.poppinsPlayerHeader
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 13
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func createSecondaryButtonWith(label: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle(label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.setTitleColor(.seaFoamBlue, for: .normal)
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
    
    func createTableRow(title: String, accessoryType: UITableViewCell.AccessoryType = .none) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .backgroundDarkBlack
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = title
        cell.selectionStyle = .none
        cell.accessoryType = accessoryType
        
        return cell
    }
    
    func createEditableTableRow(title: String, placeholder: String) -> UITableViewCell{
        
        let cell = createTableRow(title: title)
        let textField = UITextField(frame: CGRect(x:  40, y: 0, width: cell.frame.width, height: cell.frame.height))
        
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        textField.keyboardAppearance = .dark
        textField.returnKeyType = .default
        textField.textAlignment = .right
        
        cell.addSubview(textField)
        
        return cell
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
