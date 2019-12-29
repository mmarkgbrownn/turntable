//
//  HomeView.swift
//  turntable
//
//  Created by Mark Brown on 28/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class HomeView: BaseView {
    
    let reusableComponents = ReusableComponents()
    
    let logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let homeTitleText: UILabel = {
        let label = UILabel()
        label.text = "welcome to turntable"
        label.font = UIFont.poppinsPosterText
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let homeBodyText: UILabel = {
        let label = UILabel()
        label.text = "To get started, connect a Spotify account."
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.init(r: 208, g: 208, b: 208)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionText = "To connect your account, Turntable will need to open Spotify. Turntable uses Spotify to provide a vast library of music for your event."

    //let label
    
    lazy var homeDescriptionText = reusableComponents.createDescriptionWith(text: descriptionText)
    
    lazy var homeButton = reusableComponents.createButtonWith(label: "Connect Spotify")
    
    lazy var logoutButton = reusableComponents.createSecondaryButtonWith(label: "Logout")
    
    override func setupView() {
        
        let views = [logo, homeTitleText, homeBodyText, homeButton, logoutButton, homeDescriptionText]
        views.forEach { addSubview($0) }
        
        // Logo positioning
        logo.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 68, height: 68))
        
        //Home title positioning
        homeTitleText.anchor(top: logo.bottomAnchor, leading: logo.leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16))
        
        //Home body positioning
        homeBodyText.anchor(top: homeTitleText.bottomAnchor, leading: homeTitleText.leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 16))
        
        //Home button positioning
        homeButton.anchor(top: homeBodyText.bottomAnchor, leading: homeBodyText.leadingAnchor, bottom: nil, trailing: homeBodyText.trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 55))
        
        //Home description positioning
        homeDescriptionText.anchor(top: homeButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 62))
        
        // Logout button (hidden by default, shown if user is logged in)
        logoutButton.anchor(top: homeButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 55))
        logoutButton.isHidden = true
        logoutButton.isUserInteractionEnabled = false
        
    }
    
    public func showUserLoginStateOf(state: Bool) {
        
        if state == true {
            homeButton.titleLabel?.text = "Get Started"
            
            logoutButton.isHidden = false
            logoutButton.isUserInteractionEnabled = true
            
            homeDescriptionText.isHidden = true
            homeDescriptionText.isUserInteractionEnabled = false
        } else if state == false {
            homeButton.titleLabel?.text = "Connect Spotify"
            
            logoutButton.isHidden = true
            logoutButton.isUserInteractionEnabled = false
            
            homeDescriptionText.isHidden = false
            homeDescriptionText.isUserInteractionEnabled = true
        }
        
    }
    
}
