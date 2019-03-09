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
    
    let appURL = SPTAuth.defaultInstance().spotifyAppAuthenticationURL()
    let webURL = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
    lazy var spotifyAuthWebView = SFSafariViewController(url: webURL)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundDarkBlack
        
        let homeScreen = HomeView()
        view.addSubview(homeScreen)
        
        homeScreen.fillSuperview()
        
        homeScreen.homeButton.addTarget(self, action: #selector(connectSpotify), for: .touchUpInside)
        
    }
    
    @objc func connectSpotify() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(returnFromSpotify(_:)), name: NSNotification.Name.Spotify.authURLOpened, object: nil)
        
        if SPTAuth.supportsApplicationAuthentication() {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            present(spotifyAuthWebView, animated: true, completion: nil)
        }
        
    }
    
    @objc func returnFromSpotify(_ notification: Notification) {
        
        guard let url = notification.object as? URL else { return }
        
        spotifyAuthWebView.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.Spotify.authURLOpened, object: nil)

        SPTAuth.defaultInstance().handleAuthCallback(withTriggeredAuthURL: url) { (error, session) in
            if let error = error { self.displayErrorMessage(error: error); print("its this one"); return }
            
            Attendee.shared().spotifySession = session
            
            if let session = session {
                APIHandler.shared.getCurrentUserDetails(completion: { (result) in
                    Attendee.shared().setUser(userData: result, completion: { (success) in
                        if success == true {
                            DispatchQueue.main.async {
                                self.navigationController?.pushViewController(HostJoinSessionController(), animated: true)
                            }
                        }
                    })
                })
            }
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func displayErrorMessage(error: Error){
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    deinit{
        if let superView = spotifyAuthWebView.view
        {
            superView.removeFromSuperview()
        }
    }
    
//    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController) {
//        self.successfulLogin()
//    }
//
//    func audioStreaming(_ audioStreaming: SPTAudioStreamingController, didReceiveError error: Error) {
//        displayErrorMessage(error: error)
//    }
//
//    func firebaseLoginRegister() {
//        Auth.auth().fetchProviders(forEmail: currentUser.email) { (result, error) in
//            (result == ["password"]) ? self.logUserIn() : self.registerNewUser()
//
//        }
//    }
//
//    func logUserIn() {
//        Auth.auth().signIn(withEmail: self.currentUser.email, password: self.currentUser.id) { (user, error) in
//
//            if error != nil { print(error!); return }
//
//            return
//        }
//    }
//
//    func registerNewUser() {
//        Auth.auth().createUser(withEmail: currentUser.email, password: self.currentUser.id) { (result, error) in
//
//            if error != nil { print(error!); return }
//
//            if let savedEmail = result?.user.email, let userId = result?.user.uid {
//
//                let userDatabase = Database.database().reference().child("user").child(userId)
//                let values = ["spotifyId": self.currentUser.id, "username": self.currentUser.username, "email": savedEmail, "session": ""]
//
//                userDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
//
//                    if err != nil {
//                        print(err!)
//                        return
//                    }
//
//                    return
//
//                })
//
//            }
//        }
//    }
}
