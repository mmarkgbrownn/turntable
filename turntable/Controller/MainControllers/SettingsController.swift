//
//  SettingsController.swift
//  turntable
//
//  Created by Mark Brown on 07/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

class SettingsController: UITableViewController {
    
    // The following code implements the cells for the settings controller. Style = .value1 shows lable in detail
    // text view.
    var leaveDestroyButtonText: String?
    
    private let sessionCodeCell: UITableViewCell = {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Session Code"
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        cell.detailTextLabel?.text = String(Attendee.shared().session!)
        cell.backgroundColor = .backgroundDarkBlack
        cell.accessoryType = .none
        return cell
        
    }()
    
    private let sessionNameCell: UITableViewCell = {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Session Name"
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        cell.detailTextLabel?.text = Session.shared().sessionName
        cell.backgroundColor = .backgroundDarkBlack
        cell.accessoryType = .none
        return cell
        
    }()
    
    private let connectedAccountCell: UITableViewCell = {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Connected Account"
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        cell.backgroundColor = .backgroundDarkBlack
        cell.detailTextLabel?.text = Attendee.shared().displayName!
        cell.accessoryType = .none
        return cell
        
    }()
    
    private let historyCellSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        
        cellSwitch.onTintColor = .seaFoamBlue
        cellSwitch.isOn = true
        cellSwitch.addTarget(self, action: #selector(selectHistory), for: .valueChanged)
        
        return cellSwitch
    }()
    
    private let historyPlaylistCell: UITableViewCell = {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "Enable History Playlist"
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        cell.backgroundColor = .backgroundDarkBlack
        
        return cell
        
    }()
    
    private let helpCell = ReusableComponents().createTableRow(title: "Get Help", accessoryType: .disclosureIndicator)
    private let problemCell = ReusableComponents().createTableRow(title: "Report a Problem", accessoryType: .disclosureIndicator)
    private let feedbackCell = ReusableComponents().createTableRow(title: "Leave Feedback", accessoryType: .disclosureIndicator)
    
    private let developerCell = ReusableComponents().createTableRow(title: "The Developer", accessoryType: .disclosureIndicator)
    private let termsCell = ReusableComponents().createTableRow(title: "Terms and Conditions", accessoryType: .disclosureIndicator)
    private let dataCell = ReusableComponents().createTableRow(title: "Data Policy", accessoryType: .disclosureIndicator)
    
    // Lazy var to init these arrays properly
    private lazy var sessionCodeCells = [sessionCodeCell]
    private lazy var generalCells = [sessionNameCell, connectedAccountCell, historyPlaylistCell]
    private lazy var supportCells = [helpCell, problemCell, feedbackCell]
    private lazy var aboutCells = [developerCell, termsCell, dataCell]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.init(white: 1, alpha: 0.2)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Settings"
        view.backgroundColor = .backgroundDarkBlack
        
        // Display different label based on user status.
        if Auth.auth().currentUser?.uid == Session.shared().organiser {
            leaveDestroyButtonText = "Destroy Session"
        } else {
            leaveDestroyButtonText = "Leave Session"
        }
        
        // Setup leave session bar button item.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: leaveDestroyButtonText, style: UIBarButtonItem.Style.plain, target: self, action: #selector(leaveSession))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        
        historyPlaylistCell.accessoryView = historyCellSwitch
        
        
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.init(r: 21, g: 21, b: 21)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.init(r: 109, g: 109, b: 114)
        header.textLabel?.font = UIFont.systemFont(ofSize: 13)
        header.textLabel?.backgroundColor = UIColor.init(r: 21, g: 21, b: 21)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // Count the number of rows for each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return sessionCodeCells.count
        case 1:
            return generalCells.count
        case 2:
            return supportCells.count
        case 3:
            return aboutCells.count
        default:
            fatalError("Unknown number of section")
        }
    }
    // Indicate cell based from index path of relevant section array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            return sessionCodeCells[indexPath.row]
        case 1:
            return generalCells[indexPath.row]
        case 2:
            return supportCells[indexPath.row]
        case 3:
            return aboutCells[indexPath.row]
        default: fatalError("Unknown Section")
        }
    }

    // Set title for section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0: return "SESSION CODE"
        case 1: return "GENERAL"
        case 2: return "SUPPORT"
        case 3: return "ABOUT"
        default: fatalError("Unknown Section")
        }
    }
    
    // Set height dependin of if the section had a footer description
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch (section) {
        case 1:
            return 62
        default:
            return 1
        }
    }
    // Setup the footer description view
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        var footerCell = UIView()
        
        switch (section) {
        case 1:
            footerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 62))
            footerCell.backgroundColor = .backgroundDarkBlack
            
            let footerText = "Saves all songs that play during the event to a spotify playlist automatically"
            let seperator = ReusableComponents().createSeperatorWith()
            let footerDescription = ReusableComponents().createDescriptionWith(text: footerText)
            
            footerCell.addSubview(seperator)
            footerCell.addSubview(footerDescription)
            
            seperator.anchor(top: footerCell.topAnchor, leading: footerCell.leadingAnchor, bottom: nil, trailing: footerCell.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 0, height: 0.25))
            footerDescription.anchor(top: footerCell.topAnchor, leading: footerCell.leadingAnchor, bottom: footerCell.bottomAnchor, trailing: footerCell.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 20, right: 16), size: .init())
        default:
            footerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
        }
        
        return footerCell
    }
    // Select history action calls the API to follow playlist
    @objc func selectHistory() {
        var state: Bool = true
        
        if historyCellSwitch.isOn {
            state = false
        }
        
        SpotifyAPIHandler.shared.followUnfollowPlaylist(state: state, completion: { (success) in
            Attendee.shared().history = !state
        })
    }
    
    // Shows action sheet to confirm leaving session.
    @objc func leaveSession() {
        
        let actionSheet = UIAlertController(title: "Are you sure you want to leave this session?", message: "The history playlist will continue to update but you will no longer be able to queue music", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
            return
        }))
        actionSheet.addAction(UIAlertAction(title: leaveDestroyButtonText, style: .destructive, handler: {
            action in
            Session.shared().leaveSession()
            do{
                try Auth.auth().signOut()
                AppDelegate.shared.rootViewController.showHomeView()
            } catch let logoutError {
                print(logoutError)
            }
        }))
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = view.frame
        present(actionSheet, animated: true, completion: nil)

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
                case 2:
                    //Enable History Playlist Selected
                    if historyCellSwitch.isOn {
                        self.historyCellSwitch.setOn(false, animated: true)
                    } else {
                        self.historyCellSwitch.setOn(true, animated: true)
                    }
                    
                    selectHistory()
            default:
                break
            }
        default:
            break
        }
    }
    
}
