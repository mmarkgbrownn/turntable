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

struct Constants{
    static let clientID = "34c8c10451344f92b757fa6071c99b66"
    static let redirectURL = URL(string: "turntable://spotify/callback")
    static let sessionKey = "spotifySessionKey"
    static let tokenSwapUrl = URL(string: "https://turntable-ios.herokuapp.com/api/token")
    static let tokenRefreshUrl = URL(string: "https://turntable-ios.herokuapp.com/api/refresh_token")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let playerStreamingDelegate = PlayerController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        application.statusBarStyle = .lightContent
        
        FirebaseApp.configure()
        
        SPTAuth.defaultInstance().clientID = Constants.clientID
        SPTAuth.defaultInstance().redirectURL = Constants.redirectURL
        SPTAuth.defaultInstance().sessionUserDefaultsKey = Constants.sessionKey
        SPTAuth.defaultInstance().tokenSwapURL = Constants.tokenSwapUrl
        SPTAuth.defaultInstance().tokenRefreshURL = Constants.tokenRefreshUrl

        SPTAudioStreamingController.sharedInstance().playbackDelegate = playerStreamingDelegate
        SPTAudioStreamingController.sharedInstance().delegate = playerStreamingDelegate
        
        do {
            try SPTAudioStreamingController.sharedInstance().start(withClientId: Constants.clientID)
        } catch {
            fatalError("Couldnt start spotify SDK")
        }
        
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthUserLibraryReadScope, SPTAuthUserLibraryModifyScope, SPTAuthPlaylistModifyPublicScope]
        
        // Change Nav Bar Apperance
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    
        if SPTAuth.defaultInstance().canHandle(url) {
            NotificationCenter.default.post(name: NSNotification.Name.Spotify.authURLOpened, object: url)
            
            return true
        }
        
        return false
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Saves changes in the application's managed object context before the application terminates.
        //self.saveContext()
        Attendee.shared().storeUserDetails()
    }
    
//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//         */
//        let container = NSPersistentContainer(name: "turntable")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

extension AppDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController : RootViewController {
        return window!.rootViewController as! RootViewController
    }
    
    
}
