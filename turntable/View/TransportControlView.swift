//
//  TransportControlView.swift
//  turntable
//
//  Created by Mark Brown on 12/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class TransportControlView: BaseView {
    
    let forwardButton: UIButton = {
       
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "nextButton"), for: .normal)
        //imageView.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        
        return imageView
        
    }()
    
    let playPauseButton: UIButton = {
        
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "playButton"), for: .normal)
        //imageView.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        
        return imageView
        
    }()
    
    let previousButton: UIButton = {
        
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "previousButton"), for: .normal)
        //imageView.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        
        return imageView
        
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = .backgroundDarkBlack
        
        let views = [forwardButton, playPauseButton, previousButton]
        
        views.forEach() { addSubview($0) }
        
        playPauseButton.anchorCenterSuperview()
        previousButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 43, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        forwardButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 43), size: .init(width: 50, height: 50))
        
    }
    
}
