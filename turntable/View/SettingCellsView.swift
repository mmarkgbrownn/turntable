//
//  SettingCellsView.swift
//  turntable
//
//  Created by Mark Brown on 13/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

class SettingCellsView: UITableViewController {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupCells()
//    }
//    
//    let sessionNameCell: UITableViewCell = {
//            
//        let viewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//        viewCell.textLabel?.text = "Session Name"
//        viewCell.detailTextLabel?.text = "Marks Birthday 🥳"
//        viewCell.translatesAutoresizingMaskIntoConstraints = false
//        viewCell.accessoryType = .none
//        return viewCell
//        
//    }()
//    
//    let connectedAccountCell: UITableViewCell = {
//       
//        let viewCell = UITableViewCell(style: .value2, reuseIdentifier: nil)
//        viewCell.textLabel?.text = "Connected Account"
//        viewCell.detailTextLabel?.text = Auth.auth().currentUser?.displayName
//        viewCell.translatesAutoresizingMaskIntoConstraints = false
//        viewCell.accessoryType = .none
//        return viewCell
//        
//    }()
//    
//    let historyPlaylistCell: UITableViewCell = {
//        
//        let cell = UITableViewCell()
//        
//        cell.textLabel?.text = "Enable History Playlist"
//        
//        let historyCellSwitch = UISwitch()
//        historyCellSwitch.onTintColor = .seaFoamBlue
//        historyCellSwitch.isOn = true
//        historyCellSwitch.addTarget(self, action: #selector(selectHistory), for: .valueChanged)
//        cell.accessoryView = historyCellSwitch
//        return cell
//        
//    }()
//    
//    let helpCell = ReusableComponents().createTableRow(title: "Get Help")
//    let problemCell = ReusableComponents().createTableRow(title: "Report a Problem")
//    let feedbackCell = ReusableComponents().createTableRow(title: "Leave Feedback")
//    
//    let developerCell = ReusableComponents().createTableRow(title: "The Developer")
//    let termsCell = ReusableComponents().createTableRow(title: "Terms and Conditions")
//    let dataCell = ReusableComponents().createTableRow(title: "Data Policy")
//    
//    let generalCells = [sessionNameCell, connectedAccountCell, historyPlaylistCell]
//    let supportCells = [helpCell, problemCell, feedbackCell]
//    let aboutCells = [developerCell, termsCell, dataCell]
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch (section) {
//        case 0:
//            return generalCells.count
//        case 1:
//            return supportCells.count
//        case 2:
//            return aboutCells.count
//        default:
//            fatalError("Unknown number of section")
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch (indexPath.section) {
//        case 0:
//            generalCells[indexPath.row]
//        case 1:
//            supportCells[indexPath.row]
//        case 2:
//            aboutCells[indexPath.row]
//        default: fatalError("Unknown Section")
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch (section) {
//        case 0: return "General"
//        case 1: return "Support"
//        case 2: return "About"
//        default: fatalError("Unknown Section")
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//        var footerCell: UIView
//        
//        switch (section) {
//        case 0:
//            footerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
//            footerCell.backgroundColor = .backgroundDarkBlack
//            
//            let footerText = "Saves all songs that play during the event to a spotify playlist automatically"
//            let seperator = ReusableComponents().createSeperatorWith()
//            let footerDescription = ReusableComponents().createDescriptionWith(text: footerText)
//            
//            footerCell.addSubview(seperator)
//            footerCell.addSubview(footerDescription)
//            
//            seperator.anchor(top: footerCell.topAnchor, leading: footerCell.leadingAnchor, bottom: nil, trailing: footerCell.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 0, height: 0.25))
//            footerDescription.anchor(top: footerCell.topAnchor, leading: footerCell.leadingAnchor, bottom: footerCell.bottomAnchor, trailing: footerCell.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 20, right: 16), size: .init())
//        case 1:
//            footerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
//        case 2:
//            footerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
//        default: fatalError("Unknown Section")
//            
//        }
//        
//        return footerCell
//    }
//    
//    func setupCells() {
//        
//    }
//    
//    @objc func selectHistory() {
//        print("History")
//    }
    
}
