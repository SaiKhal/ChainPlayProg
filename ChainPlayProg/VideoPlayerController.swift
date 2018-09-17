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
        let player = AVPlayer(url: url)
        self.player = player
        player.play()
    }
    
    func playMedia(url: URL) {
        let mediaItem = AVPlayerItem.init(url: url)
        
        player?.replaceCurrentItem(with: mediaItem)
    }
}
