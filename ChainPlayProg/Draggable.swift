//
//  Draggable.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

protocol Draggable {
    func makeDraggable(selector: Selector)
    func handleDrag(_ gesture: UIPanGestureRecognizer)
    func snapToNearestCorner()
}

extension Draggable where Self: UIView {
    func makeDraggable(selector: Selector) {
        let gesture = UIPanGestureRecognizer(target: self, action: selector)
        addGestureRecognizer(gesture)
    }

    func handleDrag(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        let translation = gesture.translation(in: self)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: self)

        // Only snap to corner when user is done dragging
        if case .ended = gesture.state {
            snapToNearestCorner()
        }
    }

    func snapToNearestCorner() {
        let screenSize = UIScreen.main.bounds
        let left = 0..<screenSize.midX
        let right = screenSize.midX...screenSize.maxX
        let top = 0..<screenSize.midY
        let bottom = screenSize.midY...screenSize.maxY


        let xCoord = self.center.x
        let yCoord = self.center.y
        let newCenter: CGPoint

        switch (xCoord, yCoord) {
        case (left, top):
            print("LEFT TOP")
            let newX = (left.upperBound / 10.0 + bounds.width / 2)
            let newY = (top.upperBound / 5.0 + bounds.height / 2)
            newCenter = CGPoint(x: newX, y: newY)
        case (left, bottom):
            print("LEFT BOTTOM")
            let newX = (left.upperBound / 10.0 + bounds.width / 2)
            let newY = ((bottom.upperBound - bottom.upperBound / 5.0) + bounds.height / 2)
            newCenter = CGPoint(x: newX, y: newY)
        case (right, top):
            print("RIGHT TOP")
            let newX = ((right.upperBound / 10.0 + left.upperBound) + bounds.width / 2)
            let newY = (top.upperBound / 5.0 + bounds.height / 2)
            newCenter = CGPoint(x: newX, y: newY)
        case (right, bottom):
            print("RIGHT BOTTOM")
            let newX = ((right.upperBound / 10.0 + left.upperBound) + bounds.width / 2)
            let newY = ((bottom.upperBound - bottom.upperBound / 5.0) + bounds.height / 2)
            newCenter = CGPoint(x: newX, y: newY)
        default:
            newCenter = CGPoint(x: 0, y: 0)
        }

        UIView.animate(withDuration: 0.5) {
            self.center = newCenter
        }

    }
}
