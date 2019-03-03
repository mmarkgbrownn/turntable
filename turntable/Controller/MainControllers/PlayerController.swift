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
        
        if Session.shared().organiser == Attendee.shared().id {
            
            if let userAccessToken = Attendee.shared().spotifySession?.accessToken {
                SPTAudioStreamingController.sharedInstance().login(withAccessToken: userAccessToken)
            }
            
            redview.transportControlView.isHidden = false
            redview.bottomSeperator.isHidden = false
        }
        
        Session.shared().observeNowPlaying()
        
        redview.transportControlView.forwardButton.addTarget(self, action: #selector(skipForwards), for: .touchUpInside)
        redview.transportControlView.playPauseButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        redview.transportControlView.previousButton.addTarget(self, action: #selector(skipBackwards), for: .touchUpInside)
        
    }
    
    @objc func skipForwards() {
        SessionQueue.shared().playNextInQueue()
    }
    
    @objc func skipBackwards() {
        
    }
    
    @objc func playPause() {
        let playbackState = SPTAudioStreamingController.sharedInstance().playbackState
        print(playbackState.isPlaying)
        SPTAudioStreamingController.sharedInstance().setIsPlaying(!playbackState.isPlaying) { (error) in
            (error != nil) ? print(error!) : self.redview.switchPlayPause()
            return
        }
    }
    
    @objc func notLoggedIn() {
        present(UINavigationController(rootViewController: HomeController()), animated: true, completion: nil)
    }
    
    func displayNewTrackInPlayer(trackId: String) {
        
        if Session.shared().organiser == Attendee.shared().id {
            SPTAudioStreamingController.sharedInstance().playSpotifyURI("spotify:track:\(trackId)", startingWith: 0, startingWithPosition: 0) { (error) in
                if error != nil { print(error!); return }
            }
        }
        
        APIHandler.shared.getTrack(trackId: trackId, completion: { (track) in
            self.redview.updatePlayerView(track: track, completion: { (bool) in
                print("this shit")
            })
        })
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
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController) {
        SPTAudioStreamingController.sharedInstance().playSpotifyURI("spotify:track:\(Session.shared().nowPlaying ?? "1nNHyFaopXQu4gPazu3J2r")", startingWith: 0, startingWithPosition: 0) { (error) in
            if error != nil { print(error!); return }
        }
//        let songsForQueue = ["1nNHyFaopXQu4gPazu3J2r", "6jH61mSPOXhk9YDtqk2DGV", "0dZMFVzXCLukZ83AVyoqzi"]
//
//        songsForQueue.forEach { (track) in
//            SPTAudioStreamingController.sharedInstance().queueSpotifyURI("spotify:track:\(track)") { (error) in
//                if error != nil { print(error!); return }
//            }
//        }
    }
    
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController, didStopPlayingTrack trackUri: String) {
        SessionQueue.shared().playNextInQueue()
    }
    
    func setupPlayerDisplay() {
        
    }
}

