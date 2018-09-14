//
//  ViewController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let tableView = TableViewController()
    let videoPlayer = VideoPlayerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .orange
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
    
    func setupVideoPlayer() {
        videoPlayer.view.translatesAutoresizingMaskIntoConstraints = false
        videoPlayer.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoPlayer.view.bottomAnchor.constraint(equalTo: tableView.view.topAnchor).isActive = true
        videoPlayer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoPlayer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        videoPlayer.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setupTableView() {
        tableView.view.translatesAutoresizingMaskIntoConstraints = false
//        tableView.view.topAnchor.constraint(equalTo: videoPlayer.view.topAnchor).isActive = true
        tableView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.view.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6).isActive = true
        tableView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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

