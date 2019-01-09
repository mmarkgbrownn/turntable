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
        
        addSubview(mediaArtworkView)
        mediaArtworkView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var Track: Track? {
        didSet {
            
        }
    }
    
    let mediaArtworkView: UIView = {
        
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
    
    let seperator: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
        
    }()
    
    let shareActionView: UIView = {
        
        let imageView = UIImageView()
        return imageView
        
    }()

    let saveToLibraryActionView: UIView = {
        
        let imageView = UIImageView()
        return imageView
        
    }()
    
    let mediaTitleLabelView : UILabel = {
       
        let label = UILabel()
        label.text = "BUTTERFLY EFFECT"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let mediaArtistLabelView : UITextView = {
        
        let textView = UITextView()
        textView.text = "Travis Scott"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
        
    }()
    
    func setupViews() {
        addSubview(mediaArtworkView)
        addSubview(seperator)
        addSubview(mediaTitleLabelView)
        addSubview(mediaArtistLabelView)
        addSubview(shareActionView)
        addSubview(saveToLibraryActionView)
        
        
    }
    
}
