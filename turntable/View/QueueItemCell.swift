//
//  ResourceCell.swift
//  turntable
//
//  Created by Mark Brown on 10/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

class QueueItemCell: DatasourceCell {
    
    var queueItem: QueueItem?
    
    override var datasourceItem: Any? {
        didSet {
            
            queueItem = datasourceItem as? QueueItem
            
            if let urlString = queueItem?.imageSmall {
                let url = URL(string: urlString)
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async {
                       self.resourceArtwork.image = UIImage(data: data!)
                    }
                }

            }
            
            resourceTitle.text = queueItem?.name
            
            let subtitle = queueItem?.artist
            
            resourceSubtitle.text = subtitle
            
            if let runtime = queueItem?.runtime {
                resourceRuntime.text = String(runtime)
            }
        }
    }
    
    let resourceArtwork : UIImageView = {
        //Add image to artwork view
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    let resourceTitle : UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resourceSubtitle : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.init(white: 1, alpha: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resourceRuntime : UILabel = {
        let textView = UILabel()
        textView.textColor = UIColor.init(white: 0.96, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textAlignment = .right
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func setupViews() {
        
        super.setupViews()
        
        backgroundColor = UIColor.backgroundDarkBlack
        
        let views = [resourceArtwork, resourceTitle, resourceSubtitle, resourceRuntime]
        
        views.forEach() { addSubview($0) }

        resourceArtwork.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 16, bottom: 0, right: 0), size: .init(width: 48, height: 48))
        resourceRuntime.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16), size: .init(width: 100, height: 32))
        resourceTitle.anchor(top: resourceArtwork.topAnchor, leading: resourceArtwork.trailingAnchor, bottom: nil, trailing: resourceRuntime.leadingAnchor, padding: .init(top: 6, left: 8, bottom: 1, right: 8))
        resourceSubtitle.anchor(top: resourceTitle.bottomAnchor, leading: resourceTitle.leadingAnchor, bottom: nil, trailing: nil)
    }
}
