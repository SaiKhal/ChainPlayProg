//
//  TableViewController.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import AVKit

class TableViewController: UITableViewController {
    
    weak var delegate: MediaPlaybackDelegate?
    
    init(mediaPlaybackDelegate: MediaPlaybackDelegate) {
        super.init(style: UITableViewStyle.plain)
        self.delegate = mediaPlaybackDelegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var playerItemCache = [URL: AVPlayerItem]()
    let movies: [MediaItem] = MediaItem.movies

    
    func registerCells() {
        tableView.register(ChainPlayCell.self, forCellReuseIdentifier: "ChainPlayCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = .white
        tableView.bounces = false
        registerCells()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChainPlayCell", for: indexPath) as! ChainPlayCell
        let movie = movies[indexPath.row]
        let movieURL = movie.url
        let playerItem: AVPlayerItem
        
        if playerItemCache[movieURL] == nil {
            playerItem = AVPlayerItem.init(url: movieURL)
            playerItemCache[movieURL] = playerItem
        } else {
            playerItem = playerItemCache[movieURL]!
        }
        
        cell.configure(with: movie)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let mediaItem = movies[index]
        
        delegate?.mediaChanged(to: mediaItem)
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = MediaToolbarView()
////        tableView.setTableHeaderView(headerView: view)
//        return view
//    }

}
