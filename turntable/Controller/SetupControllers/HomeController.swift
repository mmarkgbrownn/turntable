//
//  HomeController.swift
//  turntable
//
//  Created by Mark Brown on 15/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    var currentUser = Attendee(id: "4eroaxv5q4rlv8w2nbjzrheoz", username: "turntable", email: "communications@turntableapp.co.uk", spotifyKey: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundDarkBlack
        
        let homeScreen = HomeView()
        view.addSubview(homeScreen)
        
        homeScreen.fillSuperview()
        
        homeScreen.homeButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc func handleLogin() {
        
        Auth.auth().fetchProviders(forEmail: currentUser.email) { (result, error) in
            (result == ["password"]) ? self.logUserIn() : self.registerNewUser()
            self.navigationController?.pushViewController(HostJoinSessionController(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func logUserIn() {
        Auth.auth().signIn(withEmail: self.currentUser.email, password: self.currentUser.id) { (user, error) in
            
            if error != nil { print(error!); return }
            
            return
        }
    }
    
    func registerNewUser() {
        Auth.auth().createUser(withEmail: currentUser.email, password: self.currentUser.id) { (result, error) in

            if error != nil { print(error!); return }

            if let savedEmail = result?.user.email, let userId = result?.user.uid {
                
                let userDatabase = Database.database().reference().child("user").child(userId)
                let values = ["spotifyId": self.currentUser.id, "username": self.currentUser.username, "email": savedEmail, "session": ""]
                
                userDatabase.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    if err != nil {
                        print(err!)
                        return
                    }
                    
                    return
                    
                })
                
            }
        }
    }
}
