//
//  ViewController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import AVKit

final class ChainPlayerViewController: UIViewController {
    let presenter: UIViewController //VC that presented this VC
    
    init(presenter: UIViewController) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    lazy var videoPlayer = {
        return VideoPlayerController(presenter: self.presenter, chainPlayer: self)
        
    }()
    
    lazy var tableView = {
        return TableViewController.init(mediaPlaybackDelegate: videoPlayer)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.
        addChildVC()
        setupTableView()
        setupVideoPlayer()
        setupPanGestureToDismiss()
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
            tableView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.view.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6),
            tableView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func setupPanGestureToDismiss() {
        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(didSwipeBack(_:)))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func didSwipeBack(_ gesture: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
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

