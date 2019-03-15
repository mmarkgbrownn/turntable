//
//  DummyDataSearch.swift
//  turntable
//
//  Created by Mark Brown on 08/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents

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
