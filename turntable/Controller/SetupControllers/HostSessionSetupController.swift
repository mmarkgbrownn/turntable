//
//  HostSessionSetupController.swift
//  turntable
//
//  Created by Mark Brown on 28/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class HostSessionSetupController : UITableViewController, UITextFieldDelegate {
    
    private var sessionNameCell: UITableViewCell = UITableViewCell()
    private var connectedAccountCell: UITableViewCell = UITableViewCell()
    //private var PlaylistSelectorCell: UITableViewCell = UITableViewCell()
    
    private var sessionNameTextField: UITextField = UITextField()
    
    private var enableHistoryCell: UITableViewCell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        self.title = "Setup Session"
        self.tableView.backgroundColor = .backgroundDarkBlack
        //self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.init(white: 1, alpha: 0.2)
        
        self.sessionNameCell.backgroundColor = .clear
        
        self.sessionNameTextField = UITextField(frame: CGRect(x: 16, y: 0, width: self.sessionNameCell.frame.width, height: self.sessionNameCell.frame.height))
        self.sessionNameTextField.delegate = self
        self.sessionNameTextField.textColor = .white
        self.sessionNameTextField.attributedPlaceholder = NSAttributedString(string: "Session Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        self.sessionNameTextField.keyboardAppearance = .dark
        self.sessionNameTextField.returnKeyType = .default
        
        self.sessionNameCell.addSubview(self.sessionNameTextField)
        
        self.connectedAccountCell.textLabel?.text = "Connected Account"
        self.connectedAccountCell.textLabel?.textColor = .white
        self.connectedAccountCell.backgroundColor = .clear
        self.connectedAccountCell.detailTextLabel?.text = "Test Test"
        self.connectedAccountCell.detailTextLabel?.textColor = .white
        
        
        self.enableHistoryCell.accessoryView = UISwitch()
        self.enableHistoryCell.backgroundColor = .clear
        self.enableHistoryCell.textLabel?.text = "Enable History Playlist"
        self.enableHistoryCell.textLabel?.textColor = .white
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.init(r: 21, g: 21, b: 21)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
       // header.backgroundColor = UIColor.init(r: 21, g: 21, b: 21)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if let input = textField.text {
            if input != ""{
                self.title = "Setup " + input
            } else {
                self.title = "Setup Session"
            }
        }
        
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
            case 0:
                return 2
            case 1:
                return 1
            default:
                fatalError("Unknown number of sections")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: return self.sessionNameCell
                case 1: return self.connectedAccountCell
                default: fatalError("Unkown Cell in Section 0")
            }
        case 1:
            switch (indexPath.row) {
                case 0: return self.enableHistoryCell
                default: fatalError("Unknown Cell in Section 1")
            }
        default: fatalError("Unknown Section")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
            case 0: return "General"
            case 1: return "Session Parameters"
            default: fatalError("Unknown Section")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footerText: String
        switch (section) {
        case 0: footerText = "Choose a Kick Off Playlist to get the party started. Choose from curated playlists by turntable or your own Spotify playlists."
        case 1: footerText = "Saves all songs that play during the event to a spotify playlist automatically"
        default: fatalError("Unknown Section")
        }
        
        let footerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        
        let seperator = ReusableComponents().createSeperatorWith()
        let footerDescription = ReusableComponents().createDescriptionWith(text: footerText)
        footerCell.addSubview(seperator)
        footerCell.addSubview(footerDescription)
        
        seperator.anchor(top: footerCell.topAnchor, leading: footerCell.leadingAnchor, bottom: nil, trailing: footerCell.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 0, height: 0.25))
        footerDescription.anchor(top: footerCell.topAnchor, leading: footerCell.leadingAnchor, bottom: footerCell.bottomAnchor, trailing: footerCell.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 20, right: 16), size: .init())
        
        return footerCell
    }
}
