//
//  SplashViewController.swift
//  turntable
//
//  Created by Mark Brown on 28/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class SplashViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .backgroundDarkBlack
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        makeServiceCall()
    }

    func makeServiceCall() {
        activityIndicator.startAnimating()
        
    
        if Auth.auth().currentUser?.uid == nil {
            // Shows Home Controller If Not Logged In
            AppDelegate.shared.rootViewController.showHomeView()
        } else {
            //Shows Player If Logged In
            Session.shared().checkIfInSession(completion: { (result) in
                if result == "InSession" {
                    AppDelegate.shared.rootViewController.switchToPlayerView()
                } else {
                    AppDelegate.shared.rootViewController.showHomeView()
                    print("jump login here")
                }
            })
        }
    }
}
