//
//  SessionSetupControllerViewController.swift
//  turntable
//
//  Created by Mark Brown on 15/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import Firebase
// A view for joining a session or hosting a new one.
class HostJoinSessionController: UIViewController, UITextFieldDelegate {
    
    let sessionSetupView = SessionSetupView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view and nav display, set delegate and show keyboard.
        view.backgroundColor = .backgroundDarkBlack
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Join Session"
        
        view.addSubview(sessionSetupView)
        sessionSetupView.fillSuperview()
        
        sessionSetupView.hostSessionButton.addTarget(self, action: #selector(hostSession), for: .touchUpInside)
        sessionSetupView.numberInput.addTarget(self, action: #selector(joinSession), for: .editingChanged)
        
        sessionSetupView.numberInput.delegate = self
        sessionSetupView.numberInput.becomeFirstResponder()
        
        SpotifyAPIHandler.shared.findPlaybackDevices()

    }
    // Called when the number input reaches 6 digits.
    func startJoiningSession(inputCode: String) {
        print(inputCode)
        // Retrive the specified session code details.
        Database.database().reference().child("session").child(inputCode).observeSingleEvent(of: .value, with: { (snapshot) in
            // If the snapshot returned a session, join that session else return an error message.
            if snapshot.hasChild("sessionName") {
                self.sessionSetupView.numberInput.resignFirstResponder()
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                Session.shared().joinSession(snapshot: dictionary, completion: {(success) -> Void in
                    AppDelegate.shared.rootViewController.animateDismissTransition(to: TurntableTabBarController())
                })
            } else {
                let alert = UIAlertController(title: "Can't Find Session", message: "We can't find that session! Check the code and try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }, withCancel: nil)
        
    }
    
    // Host session button moves to new view.
    @objc func hostSession() {
        self.navigationController?.pushViewController(HostSessionSetupController(), animated: true)
    }
    
    // Called when the text field has 6 digits.
    @objc func joinSession() {
        if sessionSetupView.numberInput.text!.count == 6 {
            self.startJoiningSession(inputCode: sessionSetupView.numberInput.text!)
        }
    }
    
    // Sets the limit of the text field to 6 digits.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
