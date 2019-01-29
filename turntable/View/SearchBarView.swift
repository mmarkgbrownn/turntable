//
//  SearchView.swift
//  turntable
//
//  Created by Mark Brown on 11/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SearchBar: BaseView {
    
    let background : UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundDarkBlack
        return view
    }()
    
    let searchBar : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 142/255, green: 142/255, blue: 147/255, alpha: 0.12)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let searchIcon : UIView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Search")
        icon.tintColor = UIColor.init(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        return icon
    }()
    
    let searchQueryText : UITextView = {
        let textView = UITextView()
        textView.text = "Quick Search"
        textView.textColor = UIColor.init(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        textView.backgroundColor = nil
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func setupView() {
        
        super.setupView()
        
        let views = [background, searchBar, searchIcon, searchQueryText]
        views.forEach { addSubview($0) }
        
        background.fillSuperview()
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: searchBar)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: searchBar)
        addConstraintsWithFormat(format: "H:[v1]-4-[v0]-|", views: searchQueryText, searchIcon)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: searchQueryText)
        
        searchIcon.anchor(top: searchBar.topAnchor, leading: searchBar.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 8, bottom: 0, right: 0), size: .init(width: 14, height: 14))
        //searchQueryText.anchor(top: topAnchor, leading: trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 3, left: 8, bottom: 0, right: 0), size: .init(width: 500, height: 30))
        
    }
}
