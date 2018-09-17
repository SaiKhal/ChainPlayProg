//
//  ViewController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import AVKit

protocol MediaPlaybackDelegate: class {
    func mediaChanged(to: MediaItem)
}

final class ChainPlayerViewController: UIViewController, MediaPlaybackDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    let videoPlayer = VideoPlayerController()
    lazy var tableView = {
        return TableViewController.init(mediaPlaybackDelegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addChildVC()
        setupTableView()
        setupVideoPlayer()
    }

    func addChildVC() {
        add(tableView)
        add(videoPlayer)
    }
    
    func setupVideoPlayer() {
        videoPlayer.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayer.view.topAnchor.constraint(equalTo: view.topAnchor),
            videoPlayer.view.bottomAnchor.constraint(equalTo: tableView.view.topAnchor),
            videoPlayer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoPlayer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupTableView() {
        tableView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.view.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6),
            tableView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

extension ChainPlayerViewController {
    func mediaChanged(to mediaItem: MediaItem) {
        videoPlayer.playMedia(url: mediaItem.url)
    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}

