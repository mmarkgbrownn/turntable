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
                    
                    if let id = json["id"].string, let trackName = json["name"].string, let artistName = json["artists"][0]["name"].string, let artworkLarge = json["album"]["images"][0]["url"].string, let artworkSmall = json["album"]["images"][2]["url"].string, let runtime = json["duration_ms"].int {
                    
                        let formattedRuntime = self.formatDuration(duration: runtime)
                        let track = Track(id: id, name: trackName, imageSmall: artworkSmall, imageLarge: artworkLarge, artist: artistName, runtime: formattedRuntime)
                        
                        completion(track)
                    }
                } catch {
                    
            }
            
        }.resume()
        
    }
    
    func addTrackToUserLibrary(trackId: String, completion: @escaping (Bool) -> ())  {
        
        if trackId == "" { print("no track id"); completion(false) }
        
        let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
        let json: [String: Any] = ["ids": [trackId]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    
        let url = URL(string: baseURL + "me/tracks")
        var request = URLRequest(url: url!)
    
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.httpMethod = "PUT"
    
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); completion(false); }

            completion(true)
        
        }.resume()
    }
    
    func isTrackInLibrary(trackId: String, completion: @escaping (Bool) -> ()) {
        
        if trackId == "" { print("no track id"); completion(false) }

        let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
        let url = URL(string: baseURL + "me/tracks/contains?ids=" + trackId)
        var request = URLRequest(url: url!)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!); completion(false) }
            
            do {
                let json = try JSON(data: data!)
                print(json) // <-- here is ur string                
            } catch let myJSONError {
                print(myJSONError)
            }
            
        }.resume()
    }
    
    func createPlaylist(name: String, completion: @escaping (String) -> ()) {
        
        if name == "" { print("no name"); completion("") }
        
        let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
        let json: [String: Any] = ["name" : name, "public" : true]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        let url = URL(string: baseURL + "users/\(Attendee.shared().sid!)/playlists")
        var request = URLRequest(url: url!)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); completion(""); }
            
            do {
                let json = try JSON(data: data!)
                if let playlistId = json["id"].string{
                    completion(playlistId)
                }
            } catch {
                completion("")
            }
        }.resume()
        
    }
    
    func followUnfollowPlaylist(state: Bool, completion: @escaping (Bool) -> ()) {
        guard let playlist = Session.shared().historyPlaylist else { return }
        
        let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
        
        
        let url = URL(string: baseURL + "playlists/\(playlist)/followers")
        var request = URLRequest(url: url!)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if state {
            request.httpMethod = "DELETE"
        } else {
            request.httpMethod = "PUT"
        }
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); completion(false); }

            completion(true)
            
        }.resume()
        
    }
    
    func searchTracks(query: String, completion: @escaping ([Track]) -> ()) {
        
        var searchResults: [Track] = []
        let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
        
        let queryString = query.replacingOccurrences(of: " ", with: "%20")
        let q = "query=" + queryString
        let url = URL(string: baseURL + "search?" + q + "&type=track")
        var request = URLRequest(url: url!)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!) }
            
            do {
                let json = try JSON(data: data!)
                if let tracksJson = json["tracks"]["items"].array {
                    tracksJson.forEach() {
                        if let id = $0["id"].string, let trackName = $0["name"].string, let artistName = $0["artists"][0]["name"].string, let artworkLarge = $0["album"]["images"][0]["url"].string, let artworkSmall = $0["album"]["images"][2]["url"].string, let runtime = $0["duration_ms"].int {
                            
                            let formattedRuntime = self.formatDuration(duration: runtime)
                            let track = Track(id: id, name: trackName, imageSmall: artworkSmall, imageLarge: artworkLarge, artist: artistName, runtime: formattedRuntime)
                            
                            searchResults.append(track)
                            
                        }
                    }
                    completion(searchResults)
                }
            } catch {
                
            }
            
            }.resume()
    }
    
    func fetchPlaylists(completion: (Bool) -> ()) {
        
    }
    
    func addTrackToHistory(trackId: String) {
        
       
        
        if trackId == "" { print("no track id"); return }
        
        let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
        
        guard let url = URL(string: baseURL + "playlists/\(Session.shared().historyPlaylist!)/tracks?uris=spotify:track:\(trackId)") else { return }
        var request = URLRequest(url: url)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); return }
            
            do {
                let json = try JSON(data: data!)
                print(json)
            } catch {
                return
            }
        }.resume()
        
    }
    
    func formatDuration(duration: Int) -> String {
        
        let duration = TimeInterval(duration/1000)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.allowsFractionalUnits = false
        formatter.zeroFormattingBehavior = [.pad]
        formatter.maximumUnitCount = 2
        
        guard let formattedTime = formatter.string(from: duration) else  { return "" }

        return formattedTime
    }
}
