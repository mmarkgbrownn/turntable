//
//  ViewController.swift
//  turntable
//
//  Created by Mark Brown on 02/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents
import Firebase

var player: PlayerController?

class PlayerController: DatasourceController {
    
    private let redview = PlayerMediaView()
    let statusBarBackgroundView = UIView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    
        player = self
        
        view.addSubview(redview)
        redview.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: view.frame.width, height: 528))
        
        statusBarBackgroundView.backgroundColor = UIColor(white: 18.0 / 255.0, alpha: 0)
        
        view.addSubview(statusBarBackgroundView)
        statusBarBackgroundView.fillSuperview()
        
        view.backgroundColor = .backgroundDarkBlack
        
        let playerDataSource = PlayerData()
        self.datasource = playerDataSource
        
        redview.nowPlaying = playerDataSource.nowPlaying
        
        collectionView.backgroundColor = nil
        //Use this when you have changed the size of redView
        collectionView.contentInset = UIEdgeInsets(top: 495, left: 0, bottom: 0, right: 0)
        view.bringSubviewToFront(redview)
        
        if Session.shared().organiser == Auth.auth().currentUser?.uid {
            redview.transportControlView.isHidden = false
            redview.bottomSeperator.isHidden = false
        }
        
        redview.transportControlView.forwardButton.addTarget(self, action: #selector(skipForwards), for: .touchUpInside)
        redview.transportControlView.playPauseButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        redview.transportControlView.previousButton.addTarget(self, action: #selector(skipBackwards), for: .touchUpInside)
    }
    
    @objc func skipForwards() {
        print("Forwards")
    }
    
    @objc func skipBackwards() {
        print("Previous")
    }
    
    @objc func playPause() {
        print("PlayPause")
        redview.switchPlayPause()
    }
    
    @objc func notLoggedIn() {
        present(UINavigationController(rootViewController: HomeController()), animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 16 + 48)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: view.frame.width, height: 100)
        }
        return .zero
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 16 + 48)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let opacityCalc = scrollView.contentOffset.x/320*0.8
//        print(opacityCalc)
//        statusBarBackgroundView.backgroundColor = UIColor(white: 18.0 / 255.0, alpha: opacityCalc)
//    }
    
}

