//
//  turntableTabBarController.swift
//  turntable
//
//  Created by Mark Brown on 07/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

class TurntableTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Check if the session is valid
//        if Attendee.shared().spotifySession?.isValid() ?? false {
//            // If our session is invalid we renew
//            SPTAuth.defaultInstance().renewSession(Attendee.shared().spotifySession!) { (error, session) in
//                // If renew returns error we move to home view
//                if error != nil { print(error!); AppDelegate.shared.rootViewController.showHomeView() }
//                Attendee.shared().spotifySession = session
//                return
//            }
//        } else if Attendee.shared().session == nil {
//            // Check if we have a session
//            AppDelegate.shared.rootViewController.showHomeView()
//        }
        
        //Setup Settings Controller
        let settingsController = SettingsController()
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "SettingsInactive"), selectedImage: UIImage(named: "Settings"))
        
        //Setup Player Controller
        let playerController = PlayerController()
        playerController.tabBarItem = UITabBarItem(title: "Player", image: UIImage(named: "PlayerInactive"), selectedImage: UIImage(named: "Player"))
        
        //Setup Library Controller
        let searchController = SearchController()
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "LibraryInactive"), selectedImage: UIImage(named: "Library"))
        
        //Add Controllers to tab bar list and wrap each in a navigation controller
        let tabBarList = [settingsController, playerController, searchController]
        viewControllers = tabBarList.map {
            UINavigationController(rootViewController: $0)
        }
        
        //Set Player Controller as default
        self.selectedIndex = 1
        
//        //Popup view for when new tracks are added to queue
//        let popupView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
//        popupView.backgroundColor = .seaFoamBlue
//        popupView.layer.cornerRadius = 12
//        popupView.layer.masksToBounds = true
//
//        let popupLabel = UILabel()
//        popupLabel.text = "Turntable added Hurting (Gerd Jenson Remix)"
//        popupLabel.font = UIFont.poppinsSmallBold
//        popupLabel.textColor = .white
//
//        popupView.addSubview(popupLabel)
//        popupLabel.anchor(top: popupView.topAnchor, leading: popupView.leadingAnchor, bottom: popupView.bottomAnchor, trailing: popupView.trailingAnchor, padding: .init(top: 2, left: 8, bottom: 2, right: 8))
//
//        view.addSubview(popupView)
//
//        popupView.anchor(top: nil, leading: view.leadingAnchor, bottom: tabBar.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 8, right: 8), size: .init(width: 0, height: 40))
        
    }
}
