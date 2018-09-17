//
//  ViewController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

protocol MediaPlaybackDelegate: class {
    func mediaChanged(to: MediaItem)
}

class ContainerViewController: UIViewController, MediaPlaybackDelegate {
    
    let scrollView = UIScrollView()
    lazy var tableView = {
        return TableViewController.init(mediaPlaybackDelegate: self)
    }()
    let videoPlayer = VideoPlayerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .orange
        setupScrollView()
        addChildVC()
        setupTableView()
        setupVideoPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addChildVC() {
        add(tableView)
        add(videoPlayer)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
//        scrollView.backgroundColor = .purple
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    
    func setupVideoPlayer() {
        videoPlayer.view.translatesAutoresizingMaskIntoConstraints = false
        videoPlayer.view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        videoPlayer.view.bottomAnchor.constraint(equalTo: tableView.view.topAnchor).isActive = true
        videoPlayer.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        videoPlayer.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
//        videoPlayer.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setupTableView() {
        tableView.view.translatesAutoresizingMaskIntoConstraints = false
//        tableView.view.topAnchor.constraint(equalTo: videoPlayer.view.topAnchor).isActive = true
        tableView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        tableView.view.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6).isActive = true
        tableView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        tableView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    }

}

extension ContainerViewController {
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

