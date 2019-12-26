//
//  APIHandler.swift
//  turntable
//
//  Created by Mark Brown on 16/02/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import SwiftyJSON

enum StringTemplates: String {
    case createSessionJSON = "{\"name\" : \"%@\", \"nowPlaying\" : \"%@\", \"historyPlist\" : \"%@\"}"
}

class TurntableAPIHandler : NSObject {
    
    static let shared = TurntableAPIHandler()
    
    fileprivate let encoder = JSONEncoder()
    fileprivate let decoder = JSONDecoder()
    
    fileprivate let baseURL  = "https://api.turntableapp.co.uk/"
    //fileprivate let authHeader = "Bearer " + Attendee.shared().accessToken?
    
    func requestLogin(completion: @escaping (Any) -> ()) {
        
        let url = URL(string: baseURL + "auth/requestMagicLink")
        var request = URLRequest(url: url!)
        
        let stringBody = "{\"email\" : \"markb1994@icloud.com\", \"deviceId\" : \"iPhone\"}"
        let dataBody = Data(stringBody.utf8)
        
        print(dataBody)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = dataBody
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error != nil { print(error!); return }
            
            guard let data = data else { return }
            
            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                print("JSON string = " + JSONString)
                completion(JSONString)
            }
            
        }.resume()
    }
    
    // Created endpoint but didnt test, also need to merge this with the changes made to the magic link to get auth for turntable server.
    func createSessionWith(name: String, selectedFirstTrack: String, histroyPlaylistId: String, completion: @escaping (Any) -> ()) {
        
        let url = URL(string: baseURL + "sessionManager/create")
        var request = URLRequest(url: url!)
       
        let stringBody = String(format: StringTemplates.createSessionJSON.rawValue, name, selectedFirstTrack, histroyPlaylistId)
        let dataBody = Data(stringBody.utf8)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Barer \(Attendee.shared().accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.httpBody = dataBody
        request.httpMethod = "POST"
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil { print(error!); return }
            
            guard let data = data else { return }
            
            if let JSONString = String (data: data, encoding: String.Encoding.utf8) {
                print("JSONString = " + JSONString)
                completion(JSONString)
            }
            
        }
        
        
    }
}

class SpotifyAPIHandler: NSObject {

    static let shared = SpotifyAPIHandler()
    
    // Setup the base url and parameters of the header values.
    let baseURL = "https://api.spotify.com/v1/"
    let param = "Bearer " + Attendee.shared().spotifySession!.accessToken
    
    // Get users spotify details.
    func getCurrentUserDetails(completion: @escaping (Any) -> ()) {
        
        // Build the url from the baseURL and api endpoint
        let url = URL(string: baseURL + "me")
        var request = URLRequest(url: url!)
        
        // Specifiy the authorisation, content-type and method of the task
        request.addValue(param, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); return }
            
            // Returnt the data as a JSON Object
            if let jsonData = data {
                let JSON = try! JSONSerialization.jsonObject(with: jsonData, options: [])
                completion(JSON)
            }
            
        }.resume()
    }
    
    func getTrack(trackId: String, completion: @escaping (Track) -> ()) {
        
        // Build the url from the baseURL and api endpoint
        let url = URL(string: baseURL + "tracks/" + trackId + "/?market=GB")
        var request = URLRequest(url: url!)
        
        // Specifiy the authorisation, content-type and method of the task
        request.addValue(param, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); return }
            
                do {
                    let json = try JSON(data: data!)
                    // Pick out the required data from the json response
                    if let id = json["id"].string, let trackName = json["name"].string, let artistName = json["artists"][0]["name"].string, let spotifyURL = json["external_urls"]["spotify"].string, let artworkLarge = json["album"]["images"][0]["url"].string, let artworkSmall = json["album"]["images"][2]["url"].string, let runtime = json["duration_ms"].int {
                        // Format the time for the track object
                        let formattedRuntime = self.formatDuration(duration: runtime)
                        // Create the track object with the above variables.
                        let track = Track(id: id, name: trackName, spotifyURL: spotifyURL, imageSmall: artworkSmall, imageLarge: artworkLarge, artist: artistName, runtime: formattedRuntime)
                        
                        completion(track)
                    }
                } catch {
                    
            }
            
        }.resume()
        
    }
    
    func addTrackToUserLibrary(trackId: String, completion: @escaping (Bool) -> ())  {
        
        if trackId == "" { print("no track id"); completion(false) }
        
        // Build the url from the baseURL and api endpoint
        let json: [String: Any] = ["ids": [trackId]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
        let url = URL(string: baseURL + "me/tracks")
        var request = URLRequest(url: url!)
    
        // Specifiy the authorisation, content-type and method of the task
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
        
        // Build the url from the baseURL and api endpoint
        let url = URL(string: baseURL + "me/tracks/contains?ids=" + trackId)
        var request = URLRequest(url: url!)
        
        // Specifiy the authorisation, content-type and method of the task
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
    
    func findPlaybackDevices() {
        let url = URL(string: baseURL + "me/player/devices")
        var request = URLRequest(url: url!)
        
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            
            do {
                let json = try JSON(data: data!)
                print(json)
            } catch {
                return
            }

        }.resume()
    }
    
    func createPlaylist(name: String, completion: @escaping (String) -> ()) {
        
        if name == "" { print("no name"); completion("") }
        
        // Build the url from the baseURL and api endpoint
        let json: [String: Any] = ["name" : name, "public" : true]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: baseURL + "users/\(Attendee.shared().sid!)/playlists")
        var request = URLRequest(url: url!)
        
        // Specifiy the authorisation, content-type and method of the task
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
        
        // Check for a set history playlist
        guard let playlist = Session.shared().historyPlaylist else { return }
        
        // Build the url from the baseURL and api endpoint
        let url = URL(string: baseURL + "playlists/\(playlist)/followers")
        var request = URLRequest(url: url!)
        
        // Specifiy the authorisation, content-type and method of the task
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
        
        // Init the results array
        var searchResults: [Track] = []
        
        // Build the url from the baseURL and api endpoint
        let queryString = query.replacingOccurrences(of: " ", with: "%20")
        let q = "query=" + queryString
        let url = URL(string: baseURL + "search?" + q + "&type=track")
        var request = URLRequest(url: url!)
        
        // Specifiy the authorisation, content-type and method of the task
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // URL Session sets up the task with the request, comletion block specifies what to do with response.
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!) }
            
            // Try to turn the response of the call to a JSON object, else return
            do {
                let json = try JSON(data: data!)
                // Create an array of track objects from the response
                if let tracksJson = json["tracks"]["items"].array {
                    tracksJson.forEach() {
                        // Pick out the required data from the json response
                        if let id = $0["id"].string, let trackName = $0["name"].string, let artistName = $0["artists"][0]["name"].string, let spotify = $0["external_urls"]["spotify"].string, let artworkLarge = $0["album"]["images"][0]["url"].string, let artworkSmall = $0["album"]["images"][2]["url"].string, let runtime = $0["duration_ms"].int {
                            
                            // Format the time for the track object
                            let formattedRuntime = self.formatDuration(duration: runtime)
                            // Create the track object with the above variables.
                            let track = Track(id: id, name: trackName, spotifyURL: spotify, imageSmall: artworkSmall, imageLarge: artworkLarge, artist: artistName, runtime: formattedRuntime)
                            
                            // Append the track to the search results array
                            searchResults.append(track)
                        }
                    }
                    // Return the results array
                    completion(searchResults)
                }
            } catch {
                return
            }
        }.resume()
    }
    
    // Adds track to histroy with a given track ID. Does not return on completion.
    func addTrackToHistory(trackId: String) {
        
        if trackId == "" { print("no track id"); return }
        
        // Build the url from the baseURL and api endpoint
        guard let url = URL(string: baseURL + "playlists/\(Session.shared().historyPlaylist!)/tracks?uris=spotify:track:\(trackId)") else { return }
        var request = URLRequest(url: url)
        
        // Specifiy the authorisation, content-type and method of the task
        request.addValue(param, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // URL Session sets up the task with the request, comletion block specifies what to do with response.
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil { print(error!); return }

            // Do nothing, no UI or Models need to be updated or changed
            return
            
        }.resume() // Call the URL task
        
    }
    
    // Return the correctly formatted time for display e.g. 3:45.
    func formatDuration(duration: Int) -> String {
        
        // Turn ms in to seconds
        let duration = TimeInterval(duration/1000)
        
        // Create a formatter object and setup the units and style.
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.allowsFractionalUnits = false
        formatter.zeroFormattingBehavior = [.pad]
        formatter.maximumUnitCount = 2
        
        // Create the formatted time using the formatter and duration.
        guard let formattedTime = formatter.string(from: duration) else  { return "" }

        // Return formatted time in a string format.
        return formattedTime
    }
}
