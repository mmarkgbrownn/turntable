//
//  turntableTabBarController.swift
//  turntable
//
//  Created by Mark Brown on 07/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class TurntableTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settingsController = SettingsController()
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "SettingsInactive"), selectedImage: UIImage(named: "Settings"))
        
        let playerController = PlayerController(collectionViewLayout: UICollectionViewFlowLayout())
        playerController.tabBarItem = UITabBarItem(title: "Player", image: UIImage(named: "PlayerInactive"), selectedImage: UIImage(named: "Player"))
        
        let libraryController = LibraryController()
        libraryController.tabBarItem = UITabBarItem(title: "Library", image: UIImage(named: "LibraryInactive"), selectedImage: UIImage(named: "Library"))
        
        let tabBarList = [settingsController, playerController, libraryController]
        
        viewControllers = tabBarList.map {
            UINavigationController(rootViewController: $0)
        }
    }
}
