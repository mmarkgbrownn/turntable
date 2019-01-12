//
//  ViewController.swift
//  turntable
//
//  Created by Mark Brown on 02/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class PlayerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // Private constants
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let sectionHeaderId = "sectionHeaderId"
    
    var queueItems = [
        QueueItem(track: Track(id: "fakeID", name: "Hurting (Gerd Janson Remix)", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "SG Lewis", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "AlunaGeorge", imageSmall: "", imageLarge: "")], runtime: 183000), session: Session(sessionCode: 345345, sessionName: "TestSession", maxGuests: 10, context: "Birthday Party", historyPlaylist: "fakePlayelist", organiser: Attendee(username: "Markyb", spotifyKey: "token", history: true))
, order: 1),
        QueueItem(track: Track(id: "fakeID", name: "Your Love", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "Tom Misch", imageSmall: "", imageLarge: "")], runtime: 249000), session: Session(sessionCode: 345345, sessionName: "TestSession", maxGuests: 10, context: "Birthday Party", historyPlaylist: "fakePlayelist", organiser: Attendee(username: "Markyb", spotifyKey: "token", history: true))
, order: 2),
        QueueItem(track: Track(id: "fakeID", name: "AGEN WIDA", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "Joyryde", imageSmall: "", imageLarge: ""), Artist(id: "fakeID", name: "Skrillex", imageSmall: "", imageLarge: "")], runtime: 191400), session: Session(sessionCode: 345345, sessionName: "TestSession", maxGuests: 10, context: "Birthday Party", historyPlaylist: "fakePlayelist", organiser: Attendee(username: "Markyb", spotifyKey: "token", history: true))
, order: 3),
        QueueItem(track: Track(id: "fakeID", name: "Sicko Mode", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "Travis Scott", imageSmall: "", imageLarge: "")], runtime: 307800), session: Session(sessionCode: 345345, sessionName: "TestSession", maxGuests: 10, context: "Birthday Party", historyPlaylist: "fakePlayelist", organiser: Attendee(username: "Markyb", spotifyKey: "token", history: true))
, order: 4),
        QueueItem(track: Track(id: "fakeID", name: "The Love", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "JaduHeart", imageSmall: "", imageLarge: "")], runtime: 270000), session: Session(sessionCode: 345345, sessionName: "TestSession", maxGuests: 10, context: "Birthday Party", historyPlaylist: "fakePlayelist", organiser: Attendee(username: "Markyb", spotifyKey: "token", history: true))
, order: 5)
    ]
    
    var nowPlaying = QueueItem(track: Track(id: "fakeID", name: "BUTTERFLY EFFECT", imageSmall: "", imageLarge: "", artist: [Artist(id: "fakeID", name: "Travis Scott", imageSmall: "", imageLarge: "")], runtime: 183000), session: Session(sessionCode: 345345, sessionName: "TestSession", maxGuests: 10, context: "Birthday Party", historyPlaylist: "fakePlayelist", organiser: Attendee(username: "Markyb", spotifyKey: "token", history: true)), order: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupCollectionViewLayout()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        //Collection View Setup
        collectionView.backgroundColor = .backgroundDarkBlack
        collectionView.contentInsetAdjustmentBehavior = .never
        
        //Register Cells, Header, Main Cell and Footer
        collectionView.register(ResourceCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(SectionHeaderCell.self, forCellWithReuseIdentifier: sectionHeaderId)
        collectionView.register(PlayerMediaView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    fileprivate func setupCollectionViewLayout() {
        //layout customisation
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
        }
    }
    
    //Setup Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PlayerMediaView
        header.nowPlaying = nowPlaying
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 529)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return queueItems.count+1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionHeaderId, for: indexPath) as! SectionHeaderCell
            cell.backgroundColor = .backgroundDarkBlack
            cell.header = "Up Next"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResourceCell
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = .backgroundDarkBlack
            } else {
                cell.backgroundColor = .backgroundLightBlack
            }
            cell.queueItem = queueItems[indexPath.item-1]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 16 + 48)
    }

}

