//
//  PlayerMedia.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class PlayerMediaView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        
        setupOverlayGradient()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var queueItem: QueueItem? {
        didSet {
            
        }
    }
    
    var overlayGradient : CAGradientLayer?
    
    let mediaBackgroundBlurView: UIView = {
        
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
    
    func setupOverlayGradient() {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.white, UIColor.black]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        overlayGradient = gradientLayer
    
    }
    
    let mediaArtworkView: UIView = {

        //Add image to artwork view
        let imageView = UIImageView(image: #imageLiteral(resourceName: "butterflyEffect"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.layer.applyShadow(color: .white, alpha: 0.25, x: 0, y: 10, blur: 58, spread: -30)

        //Return Image
        return imageView

    }()
    
    func createSeperator() -> UIView {
        
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.1)
        return view
        
    }
    
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
    
    func setupViews() {
        
        let artworkSeperator = createSeperator()
        let searchSeperator = createSeperator()
        
        let views = [mediaBackgroundBlurView, mediaArtworkView, artworkSeperator, mediaTitleLabelView, mediaArtistLabelView, shareActionView, saveToLibraryActionView, searchSeperator, quickSearchBarView]

        //let views = [ mediaTitleLabelView, mediaArtistLabelView, shareActionView, saveToLibraryActionView, searchSeperator, quickSearchBarView]
        views.forEach() { addSubview($0) }
        
        mediaBackgroundBlurView.fillSuperview()
        
        addConstraintsWithFormat(format: "V:|-64-[v0(273)]-38-[v1(0.5)]-16-[v2][v3]-16-[v4(0.5)]-1-[v5(69)]", views: mediaArtworkView, artworkSeperator, mediaTitleLabelView, mediaArtistLabelView, searchSeperator, quickSearchBarView)
        addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: mediaArtworkView)
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: artworkSeperator)
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: searchSeperator)
        addConstraintsWithFormat(format: "H:|-16-[v0]", views: mediaTitleLabelView)
        addConstraintsWithFormat(format: "H:|-16-[v0]", views: mediaArtistLabelView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: quickSearchBarView)
        
        saveToLibraryActionView.anchor(top: artworkSeperator.bottomAnchor, leading: nil, bottom: nil, trailing: artworkSeperator.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 16), size: .init(width: 32, height: 32))
        shareActionView.anchor(top: saveToLibraryActionView.topAnchor, leading: nil, bottom: nil, trailing: saveToLibraryActionView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 32), size: .init(width: 32, height: 32))
        
        overlayGradient?.frame = mediaBackgroundBlurView.bounds
        mediaBackgroundBlurView.layer.insertSublayer(overlayGradient!, at: 0)
        //mediaArtworkView.anchor(top: superview?.safeAreaLayoutGuide.topAnchor, leading: superview?.leadingAnchor, bottom: nil, trailing: superview?.trailingAnchor, padding: .init(top: 40, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 273))
        
    }
    
    
}
