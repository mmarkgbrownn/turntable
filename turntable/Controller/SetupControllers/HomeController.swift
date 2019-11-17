//
//  HomeController.swift
//  turntable
//
//  Created by Mark Brown on 15/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase
import SafariServices

class HomeController: UIViewController {
    
    // Set the web and app spoitfy auth ref and init webAuthView
    let appURL = SPTAuth.defaultInstance().spotifyAppAuthenticationURL()
    let webURL = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
    lazy var spotifyAuthWebView = SFSafariViewController(url: webURL)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundDarkBlack
        self.navigationItem.title = "Home"
        
        let homeScreen = HomeView()
        view.addSubview(homeScreen)
        
        homeScreen.anchorCenterYToSuperview()
        homeScreen.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 425))
        // Add gesture target
        homeScreen.homeButton.addTarget(self, action: #selector(connectSpotify), for: .touchUpInside)
        
    }
    // Function used for handling spotify login
    @objc func connectSpotify() {
        // Check to see if a spotify session exsits and is valid then retrive the user details.
        if let spotifySession = Attendee.shared().spotifySession {
            if Attendee.shared().spotifySession!.isValid() {
                self.getUserDetailsAndSet()
            } else {
                // If the session exsits but isnt valid request a new token then retrive user details.
                SPTAuth.defaultInstance().renewSession(spotifySession) { (error, session) in
                    if error != nil { print(error!); return }
                    if session != nil {
                       self.getUserDetailsAndSet()
                    }
                    return
                }
            }
        } else {
            // Setup a notification observer to call the return from spotify function when the notication is used
            NotificationCenter.default.addObserver(self, selector: #selector(returnFromSpotify(_:)), name: NSNotification.Name.Spotify.authURLOpened, object: nil)
            // Choose which auth procees to use
            if SPTAuth.supportsApplicationAuthentication() {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                present(spotifyAuthWebView, animated: true, completion: nil)
            }
        }
    }
    // Called when notified about a return from spotify
    @objc func returnFromSpotify(_ notification: Notification) {
        // Extract the url from the notification
        guard let url = notification.object as? URL else { return }
        // Dismiss the web view
        spotifyAuthWebView.dismiss(animated: true, completion: nil)
        // Remove the observer for the notification
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.Spotify.authURLOpened, object: nil)
        // Authorise and get a session using the url
        SPTAuth.defaultInstance().handleAuthCallback(withTriggeredAuthURL: url) { (error, session) in
            if let error = error { self.displayErrorMessage(error: error); return }
            // If a session was returned then set the session and setup the user
            if session != nil {
                Attendee.shared().spotifySession = session
                self.getUserDetailsAndSet()
            }
        }
    }
    // Get the users details and set them.
    fileprivate func getUserDetailsAndSet() {
        SpotifyAPIHandler.shared.getCurrentUserDetails(completion: { (result) in
            Attendee.shared().setUser(userData: result, completion: { (success) in
                if success == true && Attendee.shared().product == "premium" {
                    //The user was set and they are a premium user
                    DispatchQueue.main.async {
                        TurntableAPIHandler.shared.requestLogin { (res) in
                            print(res)
                            DispatchQueue.main.async {
                                self.navigationController?.pushViewController(MagicLinkController(), animated: true)
                            }
                        }
                    }
                } else if success == true {
                    //The user was set but they arent a premium user.
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(HostJoinSessionController(), animated: true)
                    }
                }
            })
        })
    }
    // Handels the error from spotify if one gets returned
    func displayErrorMessage(error: Error){
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    // Prepare view
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    // Handle the removal of the webview
    deinit{
        if let superView = spotifyAuthWebView.view
        {
            superView.removeFromSuperview()
        }
    }
}
