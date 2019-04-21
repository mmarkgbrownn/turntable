//
//  AppDelegate.swift
//  turntable
//
//  Created by Mark Brown on 02/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import CoreData
import Firebase

// Setup application constants. These details need to be protected in some way?
struct Constants{
    //Details provided when setting up the spotify developer account.
    static let clientID = "34c8c10451344f92b757fa6071c99b66"
    static let redirectURL = URL(string: "turntable://spotify/callback")
    static let sessionKey = "spotifySessionKey"
    
    // These heroku apps handel the token swapping mechanisim when the current token expires.
    static let tokenSwapUrl = URL(string: "https://turntable-ios.herokuapp.com/api/token")
    static let tokenRefreshUrl = URL(string: "https://turntable-ios.herokuapp.com/api/refresh_token")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Set this up so we dont have to use storyboards.
    var window: UIWindow?
    
    // Set the streaming controller delegate to the player controller.
    let playerStreamingDelegate = PlayerController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // Set the app secrets to the spotify auth object.
        SPTAuth.defaultInstance().clientID = Constants.clientID
        SPTAuth.defaultInstance().redirectURL = Constants.redirectURL
        SPTAuth.defaultInstance().sessionUserDefaultsKey = Constants.sessionKey
        SPTAuth.defaultInstance().tokenSwapURL = Constants.tokenSwapUrl
        SPTAuth.defaultInstance().tokenRefreshURL = Constants.tokenRefreshUrl

        // Set the streaming controllers shared instances delegate to the player class.
        SPTAudioStreamingController.sharedInstance().playbackDelegate = playerStreamingDelegate
        SPTAudioStreamingController.sharedInstance().delegate = playerStreamingDelegate
        
        // Attempt to initiate the streaming controller without a set user.
        do {
            try SPTAudioStreamingController.sharedInstance().start(withClientId: Constants.clientID)
        } catch {
            fatalError("Couldnt start spotify SDK")
        }
        
        // The list of requested scopes for the actions that are taken of behalf of the user.
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthUserLibraryReadScope, SPTAuthUserLibraryModifyScope, SPTAuthPlaylistModifyPublicScope, SPTAuthUserReadEmailScope, SPTAuthUserReadBirthDateScope, SPTAuthUserReadPrivateScope]
        
        // Change Nav Bar Apperance.
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.isTranslucent = false
        navBarAppearance.barTintColor = .backgroundLightBlack
        navBarAppearance.tintColor = .seaFoamBlue
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // Change Tab Bar Appearance.
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.isTranslucent = false
        tabBarAppearance.barTintColor = UIColor.backgroundLightBlack
        tabBarAppearance.tintColor = UIColor.seaFoamBlue
        
        // Set the window as the visable view.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // Called when returning to the app from spotify and notifies the home notification center.
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    
        if SPTAuth.defaultInstance().canHandle(url) {
            NotificationCenter.default.post(name: NSNotification.Name.Spotify.authURLOpened, object: url)
            return true
        }
        
        return false
    }
    
    // Called as the application is closed
    func applicationWillTerminate(_ application: UIApplication) {
        
        // Saves changes in the application's user default object before the application terminates.
        Attendee.shared().storeUserDetails()
        
        // If the user is in a session kill the observers.
        if Attendee.shared().session != "" {
            
            guard let sessionKey = Attendee.shared().session else { return }
            
            let sessionQueueDatabase = Database.database().reference().child("sessionQueue").child(sessionKey)
            let sessionDatabase = Database.database().reference().child("session").child(sessionKey)
            
            sessionQueueDatabase.removeAllObservers()
            sessionDatabase.removeAllObservers()
        }
    }
}

// Create a refrence to the appDelegate for use in the splash view controller
extension AppDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController : RootViewController {
        return window!.rootViewController as! RootViewController
    }
    
    
}
