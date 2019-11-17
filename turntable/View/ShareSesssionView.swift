//
//  ShareSesssionView.swift
//  turntable
//
//  Created by Mark Brown on 19/04/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class ShareSessionView : BaseView {
    
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
    
    override func setupView() {
        
        let views = [sessionLabel, sessionKeyLabel, shareSessionButton, dismissSessionKeyButton, helpDescription]
        views.forEach { addSubview($0) }
        
        sessionLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 0))
        
        sessionKeyLabel.anchor(top: nil, leading: sessionLabel.leadingAnchor, bottom: nil, trailing: sessionLabel.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        sessionKeyLabel.anchorCenterYToSuperview()
        
        helpDescription.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 24, right: 16), size: .init(width: 0, height: 0))
        
        dismissSessionKeyButton.anchor(top: nil, leading: helpDescription.leadingAnchor, bottom: helpDescription.topAnchor, trailing: helpDescription.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 0, height: 44))
        
        shareSessionButton.anchor(top: nil, leading: dismissSessionKeyButton.leadingAnchor, bottom: dismissSessionKeyButton.topAnchor, trailing: dismissSessionKeyButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 0, height: 55))
    }
    
}
