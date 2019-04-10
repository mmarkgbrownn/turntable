//
//  ShareSessionController.swift
//  turntable
//
//  Created by Mark Brown on 31/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class ShareSessionController: UIViewController {
    
    let sessionLabel : UILabel = {
        let label = UILabel()
        
        label.text = "Your session code is:"
        label.font = UIFont.poppinsPosterText
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = .white
        
        return label
    }()
    
    let sessionKeyLabel : UILabel = {
       
        let label = UILabel()
        
        label.text = Session.shared().sessionKey
        label.font = UIFont.poppinsPosterText
        label.textAlignment = .center
        label.textColor = .white
        
        return label
        
    }()
    
    let shareSessionButton = ReusableComponents().createButtonWith(label: "Share Session")
    
    let dismissSessionKeyButton = ReusableComponents().createSecondaryButtonWith(label: "Done")
    
    let helpDescription = ReusableComponents().createDescriptionWith(text: "Once you've dismissed this page you can find the session code again later under Settings > Session Code")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundLightBlack
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let views = [sessionLabel, sessionKeyLabel, shareSessionButton, dismissSessionKeyButton, helpDescription]
        views.forEach { view.addSubview($0) }
        
        sessionLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 0))
        
        sessionKeyLabel.anchor(top: nil, leading: sessionLabel.leadingAnchor, bottom: nil, trailing: sessionLabel.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        sessionKeyLabel.anchorCenterYToSuperview()
        
        helpDescription.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 24, right: 16), size: .init(width: 0, height: 0))
        
        dismissSessionKeyButton.anchor(top: nil, leading: helpDescription.leadingAnchor, bottom: helpDescription.topAnchor, trailing: helpDescription.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 0, height: 44))

        shareSessionButton.anchor(top: nil, leading: dismissSessionKeyButton.leadingAnchor, bottom: dismissSessionKeyButton.topAnchor, trailing: dismissSessionKeyButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 0, height: 55))
        
        shareSessionButton.addTarget(self, action: #selector(shareSession), for: .touchUpInside)
        dismissSessionKeyButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func shareSession() {
        // text to share
        let text = "Join Turntable and add music to my session: " + Session.shared().sessionKey!
        let myWebsite = NSURL(string:"https://turntableapp.co.uk")
        
        // set up activity view controller
        let textToShare = [ text , myWebsite! ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)

    }
    
    @objc func dismissController() {
        AppDelegate.shared.rootViewController.switchToPlayerView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
