//
//  MagicLinkController.swift
//  turntable
//
//  Created by Mark Brown on 16/10/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class MagicLinkController: UIViewController {
    
    let magicLinkView = MagicLinkView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundDarkBlack
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Check Your Email"
        
        magicLinkView.email = Attendee.shared().email
        view.addSubview(magicLinkView)
        magicLinkView.fillSuperview()
        magicLinkView.openButton.addTarget(self, action: #selector(openMail), for: .touchUpInside)
        magicLinkView.resendButton.addTarget(self, action: #selector(sendSupportEmail), for: .touchUpInside)
    }
    
    @objc fileprivate func openMail() {
        guard let mailURL = URL(string: "message://") else { return }
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc fileprivate func sendSupportEmail() {
        guard let sendMailURL = URL(string: "mailto:help@turntableapp.co.uk") else { return }
        if UIApplication.shared.canOpenURL(sendMailURL) {
            UIApplication.shared.open(sendMailURL, options: [:], completionHandler: nil)
        }
    }
}
