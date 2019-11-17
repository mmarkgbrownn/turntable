//
//  PlayerMedia.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import LBTAComponents

class PlayerMediaView: DatasourceCell {
    
    let reusableComponents = ReusableComponents()
    
    override var datasourceItem: Any? {
        didSet {
            
            guard let nowPlaying = datasourceItem as? Track else { return }
            
            if let urlString = nowPlaying.imageLarge {
                let url = URL(string: urlString)
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        self.mediaArtworkView.image = UIImage(data: data!)
                        self.mediaBackgroundBlurView.image = UIImage(data: data!)
                    }
                }
                
            }
            
        }
    }
    
    var overlayGradient : CAGradientLayer?
    
    let mediaBackgroundBlurView: UIImageView = {
        
        //Add image to artwork view
        let imageView = UIImageView(image: #imageLiteral(resourceName: "butterflyEffect"))
        imageView.contentMode = .scaleAspectFill
        
        //Add Blur effect to image view + mask to bounds
        let blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = imageView.frame
        imageView.addSubview(effectView)
        imageView.layer.masksToBounds = true
        
        //Return Image
        return imageView
        
    }()
    
    let gradientLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let mediaArtworkView: UIImageView = {

        let imageView = UIImageView(image: #imageLiteral(resourceName: "butterflyEffect"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.layer.applyShadow(color: .white, alpha: 0.25, x: 0, y: 10, blur: 58, spread: -30)
        return imageView

    }()
    
    let quickSearchBarView : UIView = {
        
        let view = SearchBar()
        return view
        
    }()
    
    lazy var artworkSeperator = reusableComponents.createSeperatorWith()
    
    override func setupViews() {
        
        super.setupViews()
        
        // Get Artwork padding value
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let artworkWidth = (CGFloat(screenWidth) / 100) * 70
        
        // Initialise views
        let views = [mediaBackgroundBlurView, mediaArtworkView, artworkSeperator]
        
        // For each view in views add to as subview
        views.forEach() { addSubview($0) }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.backgroundDarkBlack.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (artworkWidth + 125))
        
        mediaBackgroundBlurView.layer.addSublayer(gradientLayer)
        
        // Center artwork on X axis and then set top padding and dimensions
        mediaArtworkView.anchorCenterXToSuperview()
        mediaArtworkView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: artworkWidth, height: artworkWidth))
        
        artworkSeperator.anchor(top: mediaArtworkView.bottomAnchor, leading: mediaBackgroundBlurView.leadingAnchor, bottom: nil, trailing: mediaBackgroundBlurView.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0), size: .init(width: screenWidth, height: 0.5))
        
        mediaBackgroundBlurView.anchor(top: topAnchor, leading: leadingAnchor, bottom: artworkSeperator.topAnchor, trailing: trailingAnchor, padding: .init(), size: .init(width: 0, height: 0))
    }
}

