//
//  VideoPlayerController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import AVKit


class VideoPlayerController: AVPlayerViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.showsPlaybackControls = false
    }
    
    override func viewDidLoad() {

        guard let url = URL(string: "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        // Create a new AVPlayerViewController and pass it a reference to the player.
        self.player = player
//        self.showsPlaybackControls = false
        player.play()
        
//        view.backgroundColor = .purple
//        view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        view.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}
