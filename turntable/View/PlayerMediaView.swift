//
//  PlayerMedia.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class PlayerMediaView: BaseView {
    
    let reusableComponents = ReusableComponents()
    
    var nowPlaying: QueueItem? {
        didSet {
            
            if let urlString = nowPlaying?.imageLarge {
                let url = URL(string: "https://i.scdn.co/image/" + urlString)
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        self.mediaArtworkView.image = UIImage(data: data!)
                        self.mediaBackgroundBlurView.image = UIImage(data: data!)
                    }
                }
                
            }
            
            if let title = nowPlaying?.name {
                mediaTitleLabelView.text = title
            }
            if let artist = nowPlaying?.artist {
                mediaArtistLabelView.text = artist
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
    
    let shareActionView: UIView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Share")
        return imageView
        
    }()

    let saveToLibraryActionView: UIView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Save")
        return imageView
        
    }()
    
    let mediaTitleLabelView : UILabel = {
       
        let label = UILabel()
        label.text = "BUTTERFLY EFFECT"
        label.numberOfLines = 0
        label.font = UIFont.poppinsPlayerHeader
        label.textColor = UIColor.init(white: 0.96, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let mediaArtistLabelView : UILabel = {
        
        let label = UILabel()
        label.text = "Travis Scott"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let quickSearchBarView : UIView = {
        
        let view = SearchBar()
        return view
        
    }()
    
    lazy var artworkSeperator = reusableComponents.createSeperatorWith()
    lazy var searchSeperator = reusableComponents.createSeperatorWith()
    lazy var bottomSeperator = reusableComponents.createSeperatorWith()
    
    override func setupView() {
        
        super.setupView()
        
        // Get Artwork padding value
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let artworkPadding = (CGFloat(screenWidth) / 2) - (273 / 2)
        
        // Initialise views
        let views = [mediaBackgroundBlurView, mediaArtworkView, artworkSeperator, mediaTitleLabelView, mediaArtistLabelView, shareActionView, saveToLibraryActionView, searchSeperator, quickSearchBarView, bottomSeperator]
        
        // For each view in views add to as subview
        views.forEach() { addSubview($0) }
        
        // Fill view with background
        mediaBackgroundBlurView.fillSuperview()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.backgroundDarkBlack.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 460)
        
        mediaBackgroundBlurView.layer.addSublayer(gradientLayer)
        
        // Add constraints for added views
        addConstraintsWithFormat(format: "V:|-64-[v0(273)]-38-[v1(0.25)]-16-[v2][v3]-16-[v4(0.25)]-1-[v5(70)][v6(0.5)]", views: mediaArtworkView, artworkSeperator, mediaTitleLabelView, mediaArtistLabelView, searchSeperator, quickSearchBarView, bottomSeperator)
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: artworkSeperator)
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: searchSeperator)
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: bottomSeperator)
        addConstraintsWithFormat(format: "H:|-16-[v0]", views: mediaTitleLabelView)
        addConstraintsWithFormat(format: "H:|-16-[v0]", views: mediaArtistLabelView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: quickSearchBarView)
        
        mediaArtworkView.anchor(top: nil, leading: mediaBackgroundBlurView.leadingAnchor, bottom: nil, trailing: mediaBackgroundBlurView.trailingAnchor, padding: .init(top: 0, left: artworkPadding, bottom: 0, right: artworkPadding), size: .init(width: 0, height: 273))
        
        saveToLibraryActionView.anchor(top: artworkSeperator.bottomAnchor, leading: nil, bottom: nil, trailing: artworkSeperator.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 16), size: .init(width: 32, height: 32))
        
        shareActionView.anchor(top: saveToLibraryActionView.topAnchor, leading: nil, bottom: nil, trailing: saveToLibraryActionView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 32), size: .init(width: 32, height: 32))
        
    }
}

