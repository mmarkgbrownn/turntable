//
//  turntableTabBarController.swift
//  turntable
//
//  Created by Mark Brown on 07/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class turntableTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settingsController = SettingsController()
        settingsController.tabBarItem.title = "Settings"
        settingsController.tabBarItem.image = UIImage(named: "Settings")
        
        let playerController = PlayerController()
        playerController.tabBarItem.title =  "Player"
        playerController.tabBarItem.image = UIImage(named: "Player")
        
        let libraryController = LibraryController()
        libraryController.tabBarItem.title = "Library"
        libraryController.tabBarItem.image = UIImage(named: "Library")
        
        viewControllers = [settingsController, playerController, libraryController]
    }
}
