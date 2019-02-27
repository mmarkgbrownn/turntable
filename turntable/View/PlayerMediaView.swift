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
    
    var nowPlaying: Track? {
        didSet {
            
            if let urlString = nowPlaying?.imageLarge {
                let url = URL(string: urlString)
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
    var playPauseState: String = "Pause"
    
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
    
    let shareActionView: UIButton = {
        
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "Share"), for: .normal)
        //imageView.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        return imageView
        
    }()

    let saveToLibraryActionView: UIButton = {
        
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "Save"), for: .normal)
        return imageView
        
    }()
    
    let mediaTitleLabelView : UILabel = {
       
        let label = UILabel()
        label.text = "BUTTERFLY EFFECT"
        label.lineBreakMode = .byTruncatingTail
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
    
    let transportControlView = TransportControlView()
    
    lazy var artworkSeperator = reusableComponents.createSeperatorWith()
    lazy var searchSeperator = reusableComponents.createSeperatorWith()
    lazy var bottomSeperator = reusableComponents.createSeperatorWith()
    
    override func setupView() {
        
        super.setupView()
        
        // Get Artwork padding value
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let artworkWidth = (CGFloat(screenWidth) / 100) * 70
        
        // Initialise views
        let views = [mediaBackgroundBlurView, mediaArtworkView, artworkSeperator, mediaTitleLabelView, mediaArtistLabelView, shareActionView, saveToLibraryActionView, searchSeperator, transportControlView, bottomSeperator]
        
        // For each view in views add to as subview
        views.forEach() { addSubview($0) }
        
        // Fill view with background
        mediaBackgroundBlurView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(), size: .init(width: 0, height: (artworkWidth + 64 + 38)))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.backgroundDarkBlack.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (artworkWidth + 64 + 38))
        
        mediaBackgroundBlurView.layer.addSublayer(gradientLayer)
        
        // Add constraints for added views
//        addConstraintsWithFormat(format: "V:|-64-[v0(273)]-38-[v1(0.25)]-16-[v2][v3]-16-[v4(0.25)]-1-[v5(80)][v6(0.5)]", views: mediaArtworkView, artworkSeperator, mediaTitleLabelView, mediaArtistLabelView, searchSeperator,                                           transportControlView, bottomSeperator)
//        addConstraintsWithFormat(format: "H:|-[v0]-|", views: artworkSeperator)
//        addConstraintsWithFormat(format: "H:|-[v0]-|", views: searchSeperator)
//        addConstraintsWithFormat(format: "H:|-[v0]-|", views: bottomSeperator)
//        addConstraintsWithFormat(format: "H:|-16-[v0]", views: mediaTitleLabelView)
//        addConstraintsWithFormat(format: "H:|-16-[v0]", views: mediaArtistLabelView)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: transportControlView)
        
        // Center artwork on X axis and then set top padding and dimensions
        mediaArtworkView.anchorCenterXToSuperview()
        mediaArtworkView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0), size: .init(width: artworkWidth, height: artworkWidth))
        
        artworkSeperator.anchor(top: mediaArtworkView.bottomAnchor, leading: mediaBackgroundBlurView.leadingAnchor, bottom: nil, trailing: mediaBackgroundBlurView.trailingAnchor, padding: .init(top: 38, left: 0, bottom: 0, right: 0), size: .init(width: screenWidth, height: 0.5))
        
        saveToLibraryActionView.anchor(top: artworkSeperator.bottomAnchor, leading: nil, bottom: nil, trailing: artworkSeperator.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 16), size: .init(width: 32, height: 32))

        shareActionView.anchor(top: saveToLibraryActionView.topAnchor, leading: nil, bottom: nil, trailing: saveToLibraryActionView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 32), size: .init(width: 32, height: 32))
        
        mediaTitleLabelView.anchor(top: artworkSeperator.bottomAnchor, leading: mediaBackgroundBlurView.leadingAnchor, bottom: nil, trailing: shareActionView.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 0))
        
        mediaArtistLabelView.anchor(top: mediaTitleLabelView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: shareActionView.leadingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))

        searchSeperator.anchor(top: saveToLibraryActionView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))

        transportControlView.anchor(top: searchSeperator.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 66))
        
        bottomSeperator.anchor(top: transportControlView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))

        transportControlView.bringSubviewToFront(self)
        transportControlView.isHidden = true
        bottomSeperator.isHidden = true
        
        saveToLibraryActionView.addTarget(self, action: #selector(test), for: .touchUpInside)
    }
    
    func switchPlayPause() {
        if playPauseState == "Play" {
            transportControlView.playPauseButton.setImage(UIImage(named: "pauseButton"), for: .normal)
            playPauseState = "Pause"
        } else {
            transportControlView.playPauseButton.setImage(UIImage(named: "playButton"), for: .normal)
            playPauseState = "Play"
        }
    }
    
    @objc func test() {
        print("test")
    }
    
    func updatePlayerView(track: Track, completion: @escaping (Bool) -> ()) {
        
        print("does run")
        
        if let url = URL(string: track.imageLarge!), let title = track.name, let artist = track.artist {
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.mediaArtworkView.image = UIImage(data: data!)
                    self.mediaBackgroundBlurView.image = UIImage(data: data!)
                    self.mediaTitleLabelView.text = title
                    self.mediaArtistLabelView.text = artist
                    //print("In updatePlayerView: " + self.mediaTitleLabelView.text!
                    print(self.mediaTitleLabelView.text)
                    print(self.mediaArtistLabelView.text)
                    
                    completion(true)
                }
            }

        }
    }
}

