//
//  SearchResults.swift
//  turntable
//
//  Created by Mark Brown on 15/03/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

// Manages the current search results, this class is basic but could be used to generate or organise better results.
class SearchResultsManager {
    // init the search results as an empty array.
    var currentQuery: String?
    var searchResults: [Track] = []
    
    // Return the object
    private static var currentQuerySearchResult: SearchResultsManager = {
        let searchResultContainer = SearchResultsManager()
        return searchResultContainer
    }()
    
    private init() {
    }
    
    func clearSearchResults() {
        searchResults.removeAll()
    }
    
    class func shared() -> SearchResultsManager {
        return currentQuerySearchResult
    }
    
}
