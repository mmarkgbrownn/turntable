//
//  SearchViewController.swift
//  turntable
//
//  Created by Mark Brown on 11/03/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"

        let searchResultsViewController = SearchResultsViewController()
        let searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchResultsUpdater = searchResultsViewController as UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Spotify"
        navigationItem.searchController = searchController
        // Do any additional setup after loading the view.
    }
    
//    init() {
//        let searchResultsVC = SearchResultsViewController()
//        let searchVC = UISearchController(searchResultsController: searchResultsVC)
//        searchVC.searchBar.searchBarStyle = .minimal
//        searchVC.searchBar.showsCancelButton = false
//        searchVC.searchBar.delegate = searchResultsVC as? UISearchBarDelegate
//        searchVC.searchResultsUpdater = searchResultsVC as? UISearchResultsUpdating
//
//
//        let searchBar = searchVC.searchBar
//        searchBar.delegate = searchResultsVC as? UISearchBarDelegate
//        searchBar.sizeToFit()
//        searchBar.placeholder = "Search Spotify"
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
//        searchVC.hidesNavigationBarDuringPresentation = false
//        searchVC.dimsBackgroundDuringPresentation = true
//
//        super.init(searchController: searchVC)
//
//        navigationItem.titleView = searchBar
//        //        view.addSubview(searchBar)
//        //        searchBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
//
//    }
   //
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
