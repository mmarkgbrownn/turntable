//
//  ShareSessionController.swift
//  turntable
//
//  Created by Mark Brown on 31/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class ShareSessionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundLightBlack
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let shareSessionView = ShareSessionView()
        view.addSubview(shareSessionView)
        
        shareSessionView.fillSuperview()
        
        shareSessionView.shareSessionButton.addTarget(self, action: #selector(shareSession), for: .touchUpInside)
        shareSessionView.dismissSessionKeyButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
    
    @objc func shareSession() {
        // Text to share
        let text = "Join Turntable and add music to my session: " + Session.shared().sessionKey!
        let myWebsite = NSURL(string:"https://turntableapp.co.uk")
        
        // Set up activity view controller.
        let textToShare = [ text , myWebsite! ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // Present the view controller.
        self.present(activityViewController, animated: true, completion: nil)

    }
    
    @objc func dismissController() {
        AppDelegate.shared.rootViewController.animateDismissTransition(to: TurntableTabBarController())
    }

}
