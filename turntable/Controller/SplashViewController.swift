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
        
        makeServiceCall()
    }
    // Check for saved user details then check if signed into spotify, firebase and session
    func makeServiceCall() {
        
        Attendee.shared().loadUserFromUserDefaults()
        let spotifyAccessToken = Attendee.shared().spotifySession?.accessToken
        
        if Auth.auth().currentUser?.uid == nil || spotifyAccessToken == nil {
            // Not logged into Firebase + no Spotify session
            AppDelegate.shared.rootViewController.showHomeView()
        } else if Attendee.shared().session == "" || Attendee.shared().session == nil {
            // Spotify session exsists, and logged in to firebase but no session
            AppDelegate.shared.rootViewController.showHomeView()
        } else {
            // Spotify session exsists, and logged in to firebase and we are in a session
            let sessionDatabase = Database.database().reference().child("session").child(Attendee.shared().session!)
            sessionDatabase.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                Session.shared().joinSession(snapshot: dictionary, completion: { (succ) in
                    AppDelegate.shared.rootViewController.switchToPlayerView()
                })
            })
        }
    }
}
