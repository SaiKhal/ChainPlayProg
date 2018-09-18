//
//  VideoPlayerController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import AVKit

protocol MediaPlaybackDelegate: class {
    func mediaChanged(to: MediaItem)
}

class VideoPlayerController: UIViewController, MediaPlaybackDelegate {
        
    let initialVideoURL: URL = URL(string: "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8")!
    
    let presenter: UIViewController
    let chainPlayer: ChainPlayerViewController
    
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
    
    var player: AVPlayer? {
        return playerController.player
    }
    
    override func viewDidLoad() {
        UIApplication.shared.statusBarStyle = .lightContent
        view.backgroundColor = .black
        addSubviews()
        setupVideoPlayer()
        setupSwipeDownGesture()
//        player?.play()
    }
    
    init(presenter: UIViewController, chainPlayer: ChainPlayerViewController) {
        self.presenter = presenter
        self.chainPlayer = chainPlayer
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

    func setupSwipeDownGesture() {
        let swipeDownGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipeDown))
        swipeDownGesture.direction = .down
        playerController.view.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc func handleSwipeDown() {
       beginPiP(on: presenter)
    }
}

extension VideoPlayerController {
    func mediaChanged(to mediaItem: MediaItem) {
        playMedia(url: mediaItem.url)
    }
    
    func beginPiP(on vc: UIViewController) {
        guard let player = player, let nav = vc.navigationController?.view else { return }
        let pip = PiPView(player: player, presenter: presenter, chainPlayer: chainPlayer)
        nav.addSubview(pip)
        
        dismiss(animated: true, completion: {
            pip.snapToNearestCorner()
        })
    }
}


