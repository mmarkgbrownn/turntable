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
        
    }
}
