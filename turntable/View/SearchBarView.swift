//
//  SearchView.swift
//  turntable
//
//  Created by Mark Brown on 11/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SearchBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let background : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 142, green: 142, blue: 147, alpha: 0.12)
        return view
    }()
    
    let searchBar : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 142, green: 142, blue: 147, alpha: 0.12)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let searchIcon : UIView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "")
        return icon
    }()
    
    let searchQueryText : UITextView = {
        let textView = UITextView()
        textView.text = "Quick Search"
        textView.textColor = UIColor.init(red: 142, green: 142, blue: 147, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 17)
        return textView
    }()
    
    func setupSearchBar() {
        
        let views = [background, searchBar, searchIcon, searchQueryText]
        views.forEach { addSubview($0) }
        
        background.fillSuperview()
    }
}
