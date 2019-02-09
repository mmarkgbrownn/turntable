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
    
    var currentUser = Attendee()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundDarkBlack
        
        let homeScreen = HomeView()
        view.addSubview(homeScreen)
        
        homeScreen.fillSuperview()
        
        homeScreen.homeButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc func handleLogin() {
        
        // these details come from spotify
        currentUser.username = "turntable"
        currentUser.email = "communications@turntableapp.co.uk"
        let password = "4eroaxv5q4rlv8w2nbjzrheoz"
        
        Database.database().reference().child("user").child(currentUser.username!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild("email") {
                if let email = self.currentUser.email {
                    self.logUserIn(email: email, password: password)
                }
            } else {
                self.registerNewUser(email: self.currentUser.email!, password: password)
            }

        }, withCancel: nil)
        
        self.navigationController?.pushViewController(HostJoinSessionController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func logUserIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
           return
        }
    }
    
    func registerNewUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in

            if error != nil {
                print(error!)
                return
            }

            guard let savedEmail = result?.user.email else {
                print("Error, Did not create result email")
                return
            }
            
            if let username = self.currentUser.username {
                let userDatabase = Database.database().reference().child("user").child(username)
                let values = ["email": savedEmail, "session": ""]
                
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
