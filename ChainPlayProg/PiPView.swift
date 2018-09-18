//
//  PiPView.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/17/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import AVKit

class PiPView: UIView {
    let playerLayer: AVPlayerLayer
    
    init(player: AVPlayer) {
        let playerLayer = AVPlayerLayer(player: player)
        self.playerLayer = playerLayer
        
        let height = 80
        var width: Int {
            let videoRatio: Double = (16 / 9)
            return Int(videoRatio * Double(height))
        }
        let size = CGRect(x: 200, y: 600, width: width, height: height)
        super.init(frame: size)
        
        layer.cornerRadius = 5
        clipsToBounds = true
        
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.bounds
        
        self.layer.addSublayer(playerLayer)
        player.play()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
