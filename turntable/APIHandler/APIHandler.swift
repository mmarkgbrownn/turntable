//
//  APIHandler.swift
//  turntable
//
//  Created by Mark Brown on 16/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIHandler: NSObject {

    static let shared = APIHandler()
    
    let baseURL = "https://api.spotify.com/v1/"
    
    func getCurrentUserDetails(completion: @escaping (Any) -> ()) {
        
        let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
        let url = URL(string: baseURL + "me")
        var request = URLRequest(url: url!)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); return }
            
            if let jsonData = data {
                let JSON = try! JSONSerialization.jsonObject(with: jsonData, options: [])
                completion(JSON)
            }
            
        }.resume()
    }
    
    func getTrack(trackId: String, completion: @escaping (Track) -> ()) {
        
        let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
        let url = URL(string: baseURL + "tracks/" + trackId + "/?market=GB")
        var request = URLRequest(url: url!)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); return }
            
                do {
                    let json = try JSON(data: data!)
                    
                    if let id = json["id"].string, let trackName = json["name"].string, let artistName = json["artists"][0]["name"].string, let artworkLarge = json["album"]["images"][0]["url"].string, let artworkSmall = json["album"]["images"][2]["url"].string {
                    
                        let track = Track(id: id, name: trackName, imageSmall: artworkSmall, imageLarge: artworkLarge, artist: artistName, runtime: "000000")
                        
                        completion(track)
                    }
                } catch {
                    
            }
            
            }.resume()
        
    }
    
    func searchTracks(query: String, completion: ([Track]) -> ()) {
        
    }
    
    func fetchPlaylists(completion: (Bool) -> ()) {
        
    }
    
    func addTrackToHistory(track: Track, completion: (Bool) -> ()) {
        
    }
    
}
