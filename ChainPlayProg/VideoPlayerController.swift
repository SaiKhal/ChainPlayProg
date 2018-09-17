//
//  VideoPlayerController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import AVKit

class VideoPlayerController: UIViewController, AVPictureInPictureControllerDelegate, MediaPlaybackDelegate {
        
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
    
    func beginPictureInPictureMode() {
        guard let player = player else { return }
        let layer = AVPlayerLayer(player: player)
        
        //Check if Picture in Picture mode is supported on user's device
        //Picture in Picture is only available on iPads with >iOS 9
        guard AVPictureInPictureController.isPictureInPictureSupported() else {
            print("Picture in Picture mode is not supported")
            return
        }
        
        if let pipController = AVPictureInPictureController(playerLayer: layer) {
            //Assign self as a delegate to receive PIP state callbacks
            pipController.delegate = self

            if pipController.isPictureInPicturePossible {
                pipController.startPictureInPicture()
            } else {
                //#8 - isPictureInPicturePossible is a KVO enabled property
                //observing here for this property so that our class will be
                //notified when the PIP mode playback is actually possible.
                pipController.addObserver(pipController, forKeyPath: "isPictureInPicturePossible", options: [.new], context: nil)
            }
        }
    }
}

extension VideoPlayerController {
    func mediaChanged(to mediaItem: MediaItem) {
        playMedia(url: mediaItem.url)
//        beginPictureInPictureMode()
        
        let height = 80
        var width: Int {
            let videoRatio: Double = (16 / 9)
            return Int(videoRatio * Double(height))
        }
        
        let new = UIView(frame: CGRect(x: 200, y: 600, width: width, height: height))
        new.backgroundColor = .red
        
        let playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = new.bounds
        new.layer.addSublayer(playerLayer)

        playerController.view.addSubview(new)
        new.translatesAutoresizingMaskIntoConstraints = false
        
        player?.play()

//        let new = AVPlayerViewController()
//        new.player = player
//        present(new, animated: true) {
//            new.player?.play()
//        }
    }
}


