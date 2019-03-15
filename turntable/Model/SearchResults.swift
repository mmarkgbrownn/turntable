//
//  SearchResults.swift
//  turntable
//
//  Created by Mark Brown on 15/03/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class SearchResultsManager {
    
    var currentQuery: String?
    let demoTrack = Track(dictonary: ["id": "1VUWaFpGne1oiw2EjFSRRY", "name": "Hurting (Gerd Janson Remix)", "artist": "SG Lewis, Aluna George, Gerd Janson", "imageSmall": "https://i.scdn.co/image/830644e676708a8f628cdba9c8bae020b273994b", "imageLarge": "https://i.scdn.co/image/85de4509b280464293ed51e1bf230b4a8c24962f", "runtime": "3:10"])
    lazy var searchResults: [Track] = [demoTrack]
    
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
