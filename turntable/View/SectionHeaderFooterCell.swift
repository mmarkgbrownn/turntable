//
//  SectionHeaderCell.swift
//  turntable
//
//  Created by Mark Brown on 12/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class SectionHeaderCell: DatasourceCell {
    
    override var datasourceItem: Any?{
        didSet {
            if let text = datasourceItem as? String {
                 headerText.text = text
            }
        }
    }
    
    let headerText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.poppinsPlayerHeader
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    override func setupViews() {
        
        backgroundColor = UIColor.backgroundDarkBlack
    
        addSubview(headerText)
        
        headerText.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
    }
}

class SectionFooterCell: DatasourceCell {
    
    let reusableComponents = ReusableComponents()
    
    let footerText : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Save as Spotify playlist"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let historySwitch : UISwitch = {
        let viewSwitch = UISwitch()
        viewSwitch.onTintColor = .seaFoamBlue
        viewSwitch.isOn = Attendee.shared().history
        return viewSwitch
    }()
    
    let footerDescriptionText = "Saved playlists will appear in your spotfify library with the title \(Session.shared().sessionName!)."
    lazy var footerDescription = reusableComponents.createDescriptionWith(text: footerDescriptionText)
    
    override func setupViews() {
        
        backgroundColor = UIColor.backgroundDarkBlack
        
        let views = [separatorLineView, footerText, historySwitch, footerDescription]
        views.forEach { addSubview($0) }
        
        separatorLineView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
        addConstraintsWithFormat("V:|-16-[v0]-16-[v1]-16-|", views: footerText, footerDescription)
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: footerText)
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: footerDescription)
        
        historySwitch.anchor(top: footerText.topAnchor, leading: nil, bottom: nil, trailing: footerText.trailingAnchor, padding: .init(top: -6, left: 0, bottom: 16, right: 0))
        
        historySwitch.addTarget(self, action: #selector(userToFollowPlaylist), for: .touchUpInside)
        
    }
    
    @objc func userToFollowPlaylist() {
        var state: Bool = true
        
        if historySwitch.isOn {
            state = false
        }
        
        SpotifyAPIHandler.shared.followUnfollowPlaylist(state: state, completion: { (success) in
            Attendee.shared().history = !state
        })
    }
}
