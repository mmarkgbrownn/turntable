//
//  RootViewController.swift
//  turntable
//
//  Created by Mark Brown on 28/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

// Root view controller manages the main window, in here we can manage all our controllers.
class RootViewController: UIViewController {
    private var current: UIViewController
    
    // Always user splash view controller when the app starts.
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    // Set the preffered status bar style.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // Used to show the home view, displays as a pop motion
    func showHomeView() {
        
        let new = UINavigationController(rootViewController: HomeController())
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            new.navigationBar.standardAppearance = navBarAppearance
            new.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }
    
    // Used to show the player view, displays as a pop motion
    func switchToPlayerView() {
        let mainView = TurntableTabBarController()
        
        addChild(mainView)
        mainView.view.frame = view.bounds
        view.addSubview(mainView.view)
        mainView.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = mainView
    }
    
    // Display selected view and anaimate, displays by sliding up from bottom.
    func animateDismissTransition(to new: UITabBarController, completion: (() -> Void)? = nil) {
        // Set starting display
        let initialFrame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: [.curveEaseOut], animations: {
            // Set finished display
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
}
