//
//  SearchViewController.swift
//  turntable
//
//  Created by Mark Brown on 11/03/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchBarDelegate {
    
    let searchResultsViewController = SearchResultsController()
    lazy var searchController = UISearchController(searchResultsController: searchResultsViewController)

    // Setup search bar, add to navigation bar and set the search bar delegte and results controller.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"

        searchController.searchBar.delegate = searchResultsViewController as? UISearchBarDelegate
        searchController.searchResultsUpdater = searchResultsViewController
        searchController.isActive = true

        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search Spotify"
        searchBar.keyboardAppearance = .dark
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = .seaFoamBlue

        searchController.hidesNavigationBarDuringPresentation = true
        definesPresentationContext = true
        
        navigationItem.searchController = searchController

    }
    
    // Hide keyboard when return button pressed.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
