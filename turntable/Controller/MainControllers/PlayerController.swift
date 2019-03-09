//
//  ViewController.swift
//  turntable
//
//  Created by Mark Brown on 02/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import LBTAComponents
import Firebase
import AVFoundation

var player: PlayerController?

class PlayerController: DatasourceController, SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
    
    //private let redview = PlayerMediaView()
    var statusBarBackground = UIView()
    var playerMetaDataHeight: CGFloat = 88
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    
        player = self

        view.backgroundColor = .backgroundDarkBlack
        
        let playerDataSource = PlayerData()
        self.datasource = playerDataSource
        
        statusBarBackground = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: UIApplication.shared.statusBarFrame.height))
        statusBarBackground.backgroundColor = UIColor(white: 18/255, alpha: 0)
        
        view.addSubview(statusBarBackground)
        //redview.nowPlaying = playerDataSource.nowPlaying
        
        collectionView.backgroundColor = nil
        collectionView.contentInsetAdjustmentBehavior = .never
        
        if Attendee.shared().isOrganiser() {
            
            if let userAccessToken = Attendee.shared().spotifySession?.accessToken {
                SPTAudioStreamingController.sharedInstance().login(withAccessToken: userAccessToken)
            }
            
            playerMetaDataHeight = 170
        }
        
        Session.shared().observeNowPlaying()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func skipForwards() {
        SessionQueue.shared().playNextInQueue()
    }
    
    @objc func skipBackwards() {
        
    }
    
    func playPauseState() -> Bool {
        
        let playbackState = SPTAudioStreamingController.sharedInstance().playbackState
        SPTAudioStreamingController.sharedInstance().setIsPlaying(!playbackState.isPlaying) { (error) in
            //(error != nil) ? print(error!) : self.redview.switchPlayPause()
            return
        }
        return !playbackState.isPlaying
    }
    
    @objc func notLoggedIn() {
        present(UINavigationController(rootViewController: HomeController()), animated: true, completion: nil)
    }
    
    func play() {
        SPTAudioStreamingController.sharedInstance().playSpotifyURI("spotify:track:\(Session.shared().nowPlaying ?? "1nNHyFaopXQu4gPazu3J2r")", startingWith: 0, startingWithPosition: 0) { (error) in
            if error != nil { print(error!); return }
        }
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController) {
        self.play()
    }
    
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController, didStopPlayingTrack trackUri: String) {
        SessionQueue.shared().playNextInQueue()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            // Get Artwork padding value
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let artworkWidth = (CGFloat(screenWidth) / 100) * 70
            let viewHeight = artworkWidth + 120
            return CGSize(width: view.frame.width, height: viewHeight)
        } else {
            return CGSize(width: view.frame.width, height: 16 + 48)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: view.frame.width, height: 100)
        }
        return .zero
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.width, height: playerMetaDataHeight)
        default:
            return CGSize(width: view.frame.width, height: 16 + 48)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let opacityCalc = scrollView.contentOffset.y/320
        statusBarBackground.backgroundColor = UIColor(white: 18.0 / 255.0, alpha: opacityCalc)
    }
}

