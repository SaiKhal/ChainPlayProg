//
//  VideoPlayerController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import AVKit

class VideoPlayerController: UIViewController, MediaPlaybackDelegate {
        
    let initialVideoURL: URL = URL(string: "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8")!
    
    let presenter: UIViewController
    
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
        
        let swipeDownGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipeDown))
        swipeDownGesture.direction = .down
        playerController.view.addGestureRecognizer(swipeDownGesture)
    }
    
    init(presenter: UIViewController) {
        self.presenter = presenter
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
    
    @objc func handleSwipeDown() {
       beginPiP(on: presenter)
    }
}

extension VideoPlayerController {
    func mediaChanged(to mediaItem: MediaItem) {
        playMedia(url: mediaItem.url)
//        beginPictureInPictureMode()
        beginPiP(on: presenter)
    }
    
    func beginPiP(on vc: UIViewController) {
        let height = 80
        var width: Int {
            let videoRatio: Double = (16 / 9)
            return Int(videoRatio * Double(height))
        }
        
        let playerContainer = UIView(frame: CGRect(x: 200, y: 600, width: width, height: height))
        playerContainer.layer.cornerRadius = 5
        playerContainer.clipsToBounds = true
        playerContainer.backgroundColor = .red
        
        let playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = playerContainer.bounds
        
        playerContainer.layer.addSublayer(playerLayer)
        
        // must add to the navControllers view to keep the PiP window from scrolling with the tableview.
        vc.navigationController?.view.addSubview(playerContainer)
        
        playerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        player?.play()
        navigationController?.popViewController(animated: true)
    }
}


