//
//  SearchResultCell.swift
//  turntable
//
//  Created by Mark Brown on 11/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import LBTAComponents

class SearchResultCell: DatasourceCell {
    
    var searchItem: Track?
    
    override var datasourceItem: Any? {
        didSet {
            
            searchItem = datasourceItem as? Track
                        
            SessionQueue.shared().sessionQueue?.forEach({ if $0.id == searchItem?.id { resourceIcon = "inQueue" } })
            
            itemStatusIndicator.image = UIImage(named: resourceIcon)?.withRenderingMode(.alwaysTemplate)
            
            if let urlString = searchItem?.imageSmall {
                let url = URL(string: urlString)
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        self.resourceArtwork.image = UIImage(data: data!)
                    }
                }
                
            }
            
            resourceTitle.text = searchItem?.name
            
            let subtitle = searchItem?.artist
            
            resourceSubtitle.text = subtitle
            
        }
    }
    
    var resourceIcon = "addToQueue"
    
    let resourceArtwork : UIImageView = {
        //Add image to artwork view
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    let resourceTitle : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resourceSubtitle : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.init(white: 1, alpha: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemStatusIndicator : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.tintColor = .white
        return imageView
        
    }()
    
    
    
    override func setupViews() {
        
        super.setupViews()
        
        backgroundColor = UIColor.backgroundDarkBlack
        
        let views = [resourceArtwork, resourceTitle, resourceSubtitle, itemStatusIndicator]
        
        views.forEach() { addSubview($0) }
        
        addConstraintsWithFormat(format: "H:|-16-[v0(48)]", views: resourceArtwork)
        addConstraintsWithFormat(format: "V:|-8-[v0(48)]", views: resourceArtwork)
        addConstraintsWithFormat(format: "V:|-20-[v0(24)]", views: itemStatusIndicator)
        addConstraintsWithFormat(format: "H:[v0(24)]-16-|", views: itemStatusIndicator)
        
        resourceTitle.anchor(top: resourceArtwork.topAnchor, leading: resourceArtwork.trailingAnchor, bottom: nil, trailing: itemStatusIndicator.leadingAnchor, padding: .init(top: 6, left: 8, bottom: 1, right: 16) )
        resourceSubtitle.anchor(top: resourceTitle.bottomAnchor, leading: resourceTitle.leadingAnchor, bottom: nil, trailing: resourceTitle.trailingAnchor)
    }
    
    func didInteract(state: String) {
        switch state {
        case "highlight":
            backgroundColor = .backgroundLightBlack
            resourceTitle.textColor = .seaFoamBlue
            itemStatusIndicator.tintColor = UIColor(white: 1, alpha: 0.5)
        case "unhighlight":
            backgroundColor = .backgroundDarkBlack
            resourceTitle.textColor = .white
            itemStatusIndicator.tintColor = .white
        default:
            print("send state")
        }
    }
    
}
