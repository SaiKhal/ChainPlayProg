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
    let presenter: UIViewController
    let chainPlayer: ChainPlayerViewController
    
    init(player: AVPlayer, presenter: UIViewController, chainPlayer: ChainPlayerViewController) {
        let playerLayer = AVPlayerLayer(player: player)
        self.playerLayer = playerLayer
        self.chainPlayer = chainPlayer
        self.presenter = presenter
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
        
        makeDraggable()
        makeTappable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeDraggable() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func handleDrag(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        let translation = gesture.translation(in: self)
//        print("old center", self.center)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
//        print("new center", view.center)
        gesture.setTranslation(CGPoint.zero, in: self)
//        print("new center", view.center)
//        print(view.center.x, "MID IS \(UIScreen.main.bounds.midX)")
        if case .ended = gesture.state {
            snapToNearestCorner(view)
        }
    }
    
    func makeTappable() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        self.removeFromSuperview()
        let nav = presenter.navigationController
        nav?.present(chainPlayer, animated: true, completion: nil)
    }
    
    func snapToNearestCorner(_ view: UIView) {
        let screenSize = UIScreen.main.bounds
        let left = 0..<screenSize.midX
        let right = screenSize.midX...screenSize.maxX
        let top = 0..<screenSize.midY
        let bottom = screenSize.midY...screenSize.maxY
        
        
        let xCoord = view.center.x
        let yCoord = view.center.y
        let newCenter: CGPoint
        
        switch (xCoord, yCoord) {
        case (left, top):
            print("LEFT TOP")
            let newX = (left.upperBound / 10.0 + view.bounds.width / 2)
            let newY = (top.upperBound / 5.0 + view.bounds.height / 2)
            newCenter = CGPoint(x: newX, y: newY)
        case (left, bottom):
            print("LEFT BOTTOM")
            let newX = (left.upperBound / 10.0 + view.bounds.width / 2)
            let newY = ((bottom.upperBound - bottom.upperBound / 5.0) + view.bounds.height / 2)
            newCenter = CGPoint(x: newX, y: newY)
        case (right, top):
            print("RIGHT TOP")
            let newX = ((right.upperBound / 10.0 + left.upperBound) + view.bounds.width / 2)
            let newY = (top.upperBound / 5.0 + view.bounds.height / 2)
            newCenter = CGPoint(x: newX, y: newY)
        case (right, bottom):
            print("RIGHT BOTTOM")
            let newX = ((right.upperBound / 10.0 + left.upperBound) + view.bounds.width / 2)
            let newY = ((bottom.upperBound - bottom.upperBound / 5.0) + view.bounds.height / 2)
            newCenter = CGPoint(x: newX, y: newY)
        default:
            newCenter = CGPoint(x: 0, y: 0)
        }
        
        UIView.animate(withDuration: 0.5) {
            view.center = newCenter
        }
    }
    
    
}
