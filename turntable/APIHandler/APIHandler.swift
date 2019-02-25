//
//  APIHandler.swift
//  turntable
//
//  Created by Mark Brown on 16/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class APIHandler: NSObject {

    static let shared = APIHandler()
    
    let baseURL = "https://api.spotify.com/v1/"
    
    func getCurrentUserDetails(completion: @escaping (Any) -> ()) {
        
        let param = "Bearer " + Attendee.shared().accessToken!
        let url = URL(string: baseURL + "me")
        var request = URLRequest(url: url!)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); return }
            
            print(data)
            
            if let jsonData = data {
                let JSON = try! JSONSerialization.jsonObject(with: jsonData, options: [])
                completion(JSON)
            }
            
        }.resume()
    }
    
    func getTrack(uri: String, completion: (Bool) -> ()) {
        
    }
    
    func searchTracks(query: String, completion: ([Track]) -> ()) {
        
    }
    
    func fetchPlaylists(completion: (Bool) -> ()) {
        
    }
    
    func addTrackToHistory(track: Track, completion: (Bool) -> ()) {
        
    }
    
}
