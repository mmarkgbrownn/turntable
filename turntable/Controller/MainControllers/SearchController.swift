//
//  LibraryController.swift
//  turntable
//
//  Created by Mark Brown on 07/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"
        
        view?.backgroundColor = .backgroundDarkBlack
    }
    
}
