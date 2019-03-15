//
//  LibraryController.swift
//  turntable
//
//  Created by Mark Brown on 07/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SearchController: UISearchContainerViewController {
    
    let searchBarContainerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"
        
        view?.backgroundColor = .backgroundDarkBlack
        
    }
    
    init() {
        let searchResultsVC = SearchResultsViewController()
        let searchVC = UISearchController(searchResultsController: searchResultsVC)
        searchVC.searchBar.searchBarStyle = .minimal
        searchVC.searchBar.showsCancelButton = false
        searchVC.searchBar.delegate = searchResultsVC as? UISearchBarDelegate
        searchVC.searchResultsUpdater = searchResultsVC
        //searchVC.obscuresBackgroundDuringPresentation = false

        let searchBar = searchVC.searchBar
        searchBar.delegate = searchResultsVC as? UISearchBarDelegate
        searchBar.sizeToFit()
        searchBar.keyboardAppearance = .dark
        searchBar.placeholder = "Search Spotify"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        //searchVC.hidesNavigationBarDuringPresentation = false
        searchVC.dimsBackgroundDuringPresentation = true
        
        super.init(searchController: searchVC)
        navigationItem.searchController = searchVC        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
