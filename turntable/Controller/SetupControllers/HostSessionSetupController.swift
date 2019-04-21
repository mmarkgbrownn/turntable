//
//  HostSessionSetupController.swift
//  turntable
//
//  Created by Mark Brown on 28/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

// Host session controller with table view.
class HostSessionSetupController : UITableViewController, UITextFieldDelegate {
    
    // Create the componets, simmialrly to the views
    private var sessionNameCell: UITableViewCell = ReusableComponents().createTableRow(title: "Session Name")
    
    private let connectedAccountCell: UITableViewCell = {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Connected Account"
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        cell.detailTextLabel?.text = Attendee.shared().displayName
        cell.backgroundColor = .backgroundDarkBlack
        cell.accessoryType = .none
        return cell
        
    }()
    
    private var sessionNameTextField: UITextField = UITextField()
    private var histroyCellSwitch: UISwitch = UISwitch()
    
    private var socialContextCell: UITableViewCell = ReusableComponents().createTableRow(title: "Social Context")
    private var enableHistoryCell: UITableViewCell = ReusableComponents().createTableRow(title: "Enable History Playlist")
    
    private var sessionKey: String = "000000"
    private var historyEnabled: Bool = true
    
    // Set the cell and fields details
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostButton = UIBarButtonItem(title: "Host Session", style: .plain, target: self, action: #selector(createSession))
        self.navigationItem.rightBarButtonItem = hostButton
    
        // Set nav bar up
        self.title = "Setup Session"
        self.tableView.backgroundColor = .backgroundDarkBlack
        self.tableView.separatorColor = UIColor.init(white: 1, alpha: 0.2)
        
        // Setup textField with deleagte, style and placeholder
        self.sessionNameTextField = UITextField(frame: CGRect(x: -16, y: 0, width: self.view.frame.width, height: self.sessionNameCell.frame.height))
        self.sessionNameTextField.delegate = self
        self.sessionNameTextField.textColor = .white
        self.sessionNameTextField.attributedPlaceholder = NSAttributedString(string: "e.g. Mark's Birthday 🎉", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        self.sessionNameTextField.keyboardAppearance = .dark
        self.sessionNameTextField.returnKeyType = .default
        self.sessionNameTextField.textAlignment = .right
        
        self.sessionNameCell.addSubview(self.sessionNameTextField)
        
        // Setup the history switch
        self.histroyCellSwitch.onTintColor = .seaFoamBlue
        self.histroyCellSwitch.isOn = true
        self.histroyCellSwitch.addTarget(self, action: #selector(selectHistory), for: .valueChanged)
        
        self.enableHistoryCell.accessoryView = histroyCellSwitch
    }
    // Style of table view headers
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.init(r: 21, g: 21, b: 21)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    // Handle the tap to switch the history
    @objc func selectHistory() {
        if histroyCellSwitch.isOn {
            historyEnabled = true
        } else {
            historyEnabled = false
        }
    }
    
    // Hide the keyboard on hitting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Set the max length to 20 characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    // Set the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Set the number of rows in section
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
    
    // Set the cells for each row in the table
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
    
    // Set the header lable text for each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
            case 0: return "General"
            case 1: return "Session Parameters"
            default: fatalError("Unknown Section")
        }
    }
    
    // Set the footer lable  and view text for each section
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footerText: String
        
        switch (section) {
            case 0: footerText = "Choose a Kick Off Playlist to get the party started. Choose from curated playlists by turntable or your own Spotify playlists."
            case 1: footerText = "Automatically saves all songs that play during the event to a spotify playlist automatically"
            default: fatalError("Unknown Section")
        }
        
        let footerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerCell.backgroundColor = .backgroundDarkBlack
        
        let seperator = ReusableComponents().createSeperatorWith()
        let footerDescription = ReusableComponents().createDescriptionWith(text: footerText)

        footerCell.addSubview(seperator)
        footerCell.addSubview(footerDescription)
        
        seperator.anchor(top: footerCell.topAnchor, leading: footerCell.leadingAnchor, bottom: nil, trailing: footerCell.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 0, height: 0.25))
        footerDescription.anchor(top: footerCell.topAnchor, leading: footerCell.leadingAnchor, bottom: footerCell.bottomAnchor, trailing: footerCell.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 20, right: 16), size: .init())
        
        return footerCell
    }
    
    // Handle the selection of the row at the index path.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                print("Session Name Selected")
            case 1:
                print("Connected Account Selected")
            default: fatalError("No such row")
            }
        case 1:
            switch(indexPath.row) {
            case 0:
                //Enable History Playlist Selected
                if histroyCellSwitch.isOn {
                    self.histroyCellSwitch.setOn(false, animated: true)
                } else {
                    self.histroyCellSwitch.setOn(true, animated: true)
                }
                selectHistory()
            default: fatalError("No such row")
            }
        default: fatalError("No such section")
            
        }
    }
    
    @objc func createSession() {
        //create a new session by posting session name, code, owner, nowPlaying and history playlist to firebase also store this data in CoreData
        
        guard let sessionName = self.sessionNameTextField.text else { return }
        
        if sessionName != "" {
            Session.shared().setupSession(sessionName: sessionName, maxGuests: 10, context: "Party", historyPlaylist: historyEnabled, organiser: Auth.auth().currentUser!.uid)
            self.navigationController?.pushViewController(ShareSessionController(), animated: true)
        }
        
    }
}
