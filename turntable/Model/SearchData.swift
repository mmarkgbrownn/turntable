//
//  SearchData.swift
//  turntable
//
//  Created by Mark Brown on 20/04/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

// Set the search results as the datasource for the search results collection view.
class SearchData: Datasource {
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [SearchResultCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return SearchResultsManager.shared().searchResults[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return SearchResultsManager.shared().searchResults.count
    }
    
}
