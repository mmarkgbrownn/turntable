//
//  SearchViewController.swift
//  turntable
//
//  Created by Mark Brown on 11/03/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let searchResultsViewController = SearchResultsViewController()
    lazy var searchController = UISearchController(searchResultsController: searchResultsViewController)

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
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
