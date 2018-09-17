//
//  VideoPlayerController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import AVKit

class VideoPlayerController: UIViewController {
        
    let initialVideoURL: URL = URL(string: "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8")!
    
    lazy var playerController: AVPlayerViewController = {
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: initialVideoURL)
        playerController.player = player
        return playerController
    }()
    
    lazy var mediaToolbar: MediaToolbarView = {
        let view = MediaToolbarView()
        return view
    }()
    
    var player: AVPlayer? { return playerController.player }
    
    override func viewDidLoad() {
        UIApplication.shared.statusBarStyle = .lightContent
        view.backgroundColor = .black
        addSubviews()
        setupVideoPlayer()
        setupMediaToolbar()
        player?.play()
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        add(playerController)
        view.addSubview(mediaToolbar)
    }
    
    func playMedia(url: URL) {
        let mediaItem = AVPlayerItem.init(url: url)
        player?.replaceCurrentItem(with: mediaItem)
    }
    
    func setupVideoPlayer() {
        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    func setupMediaToolbar() {
        mediaToolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mediaToolbar.topAnchor.constraint(equalTo: playerController.view.bottomAnchor),
            mediaToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mediaToolbar.leadingAnchor.constraint(equalTo: playerController.view.leadingAnchor),
            mediaToolbar.trailingAnchor.constraint(equalTo: playerController.view.trailingAnchor),
            mediaToolbar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            ])
    }
    
}


