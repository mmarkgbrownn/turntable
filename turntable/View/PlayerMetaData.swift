//
//  PlayerMetaData.swift
//  turntable
//
//  Created by Mark Brown on 09/03/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import LBTAComponents

class PlayerMetaData: DatasourceCell {
    
    override var datasourceItem: Any?{
        didSet {
            if let track = datasourceItem as? Track {
                self.mediaTitleLabelView.text = track.name
                self.mediaArtistLabelView.text = track.artist
                self.resetView()
            }
        }
    }
    
    let reusableComponents = ReusableComponents()
    
    let shareActionView: UIButton = {
        
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "Share"), for: .normal)
        //imageView.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        return imageView
        
    }()
    
    let saveToLibraryActionView: UIButton = {
        
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "Save"), for: .normal)
        return imageView
        
    }()
    
    let mediaTitleLabelView : UILabel = {
        
        let label = UILabel()
        label.text = "BUTTERFLY EFFECT"
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.poppinsPlayerHeader
        label.textColor = UIColor.init(white: 0.96, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let mediaArtistLabelView : UILabel = {
        
        let label = UILabel()
        label.text = "Travis Scott"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var bottomSeperator = reusableComponents.createSeperatorWith()
    lazy var artworkSeperator = reusableComponents.createSeperatorWith()
    lazy var metaSeperator = reusableComponents.createSeperatorWith()
    
    let transportControllView = TransportControlView()
    
    override func setupViews() {
        
        let views = [saveToLibraryActionView, shareActionView, mediaTitleLabelView, mediaArtistLabelView, metaSeperator, transportControllView, bottomSeperator]
        
        views.forEach { addSubview($0) }
        
        saveToLibraryActionView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 16), size: .init(width: 32, height: 32))

        shareActionView.anchor(top: saveToLibraryActionView.topAnchor, leading: nil, bottom: nil, trailing: saveToLibraryActionView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 32), size: .init(width: 32, height: 32))

        mediaTitleLabelView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: shareActionView.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 0))
        mediaArtistLabelView.anchor(top: mediaTitleLabelView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: shareActionView.leadingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        metaSeperator.anchor(top: saveToLibraryActionView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        transportControllView.anchor(top: metaSeperator.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: frame.width, height: 82))
        bottomSeperator.anchor(top: transportControllView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        
        saveToLibraryActionView.addTarget(self, action: #selector(addSongToUserLibraryAction), for: .touchUpInside)
        
        let transportVisibility = (Attendee.shared().isOrganiser()) ? false : true
        
        transportControllView.isHidden = transportVisibility
        bottomSeperator.isHidden = transportVisibility
        
        self.bringSubviewToFront(metaSeperator)
        
        transportControllView.forwardButton.addTarget(self, action: #selector(skipTrack), for: .touchUpInside)
        transportControllView.playPauseButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        //transportControllView.previousButton.addTarget(self, action: #selector(skipBackwards), for: .touchUpInside)
        
    }
    
    @objc func playPause() {
        if player?.playPauseState() ?? false {
            transportControllView.playPauseButton.setImage(UIImage(named: "pauseButton"), for: .normal)
        } else {
            transportControllView.playPauseButton.setImage(UIImage(named: "playButton"), for: .normal)
        }
    }
    
    @objc func skipTrack() {
        player?.skipForwards()
        self.resetView()
    }
    
    func resetView() {
        transportControllView.playPauseButton.setImage(UIImage(named: "pauseButton"), for: .normal)
        saveToLibraryActionView.setImage(UIImage(named: "Save"), for: .normal)
    }
    
    func switchAddLibraryIcon(state: Bool) {
        if state {
            saveToLibraryActionView.setImage(UIImage(named: "inQueue"), for: .normal)
        } else {
            saveToLibraryActionView.setImage(UIImage(named: "Save"), for: .normal)
        }
    }
    
    @objc func addSongToUserLibraryAction() {
        if let nowPlayingId = Session.shared().nowPlaying {
            APIHandler.shared.addTrackToUserLibrary(trackId: nowPlayingId) { (result) in
                DispatchQueue.main.async {
                    self.switchAddLibraryIcon(state: result)
                }
            }
        }
    }
    
    func updatePlayerView(track: Track, completion: @escaping (Bool) -> ()) {
        if let title = track.name, let artist = track.artist {
            DispatchQueue.main.async {
                self.mediaTitleLabelView.text = title
                self.mediaArtistLabelView.text = artist
                completion(true)
            }
        }
    }
}
