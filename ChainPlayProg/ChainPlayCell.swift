//
//  ChainPlayCell.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import AVKit

class ChainPlayCell: UITableViewCell {
    
    var thumbnailIsRounded = true
    var margin: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        contentView.clipsToBounds = true
        selectionStyle = .none
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addViews()
        setupConstraints()
    }
    
    lazy var thumbnail: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
//        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "og-fox-news")
        if thumbnailIsRounded {
            iv.layer.cornerRadius = 5
            iv.clipsToBounds = true
        }
        return iv
    }()
    
    lazy var durationLabel: UIButton = {
        let button = UIButton()
        // spacing
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        
        // color
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.alpha = 0.8
        
        // text
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var videoDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.text = "HELLO NOW"
        return label
    }()
    
    func configure(with media: MediaItem) {
        let caption = media.title
        videoDescription.text = caption
        
        let randomHour = arc4random_uniform(10)
        let duration = "\(randomHour):00"
        durationLabel.setTitle(duration, for: .normal)
    }
    
    func setupConstraints() {
        setupThumbnail()
        setupLabel()
        setupDurationLabel()
    }
    
    func addViews() {
        contentView.addSubview(thumbnail)
        contentView.addSubview(videoDescription)
        thumbnail.addSubview(durationLabel)
    }
    
    func setupThumbnail() {
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true //contentView.frame.size.height/2 * 0.2
        thumbnail.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        thumbnail.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        thumbnail.trailingAnchor.constraint(equalTo: videoDescription.leadingAnchor, constant: -15).isActive = true
        thumbnail.widthAnchor.constraint(equalTo: margin.widthAnchor, multiplier: 0.4).isActive = true
        thumbnail.heightAnchor.constraint(equalTo: thumbnail.widthAnchor, multiplier: 6/11).isActive = true
    }
    
    func setupLabel() {
        videoDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoDescription.topAnchor.constraint(equalTo: thumbnail.topAnchor, constant: 10),
            videoDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            videoDescription.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            videoDescription.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -20),
            ])
        
    }
    
    func setupDurationLabel() {
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            durationLabel.bottomAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: -10),
            durationLabel.leadingAnchor.constraint(equalTo: thumbnail.leadingAnchor, constant: 10),
            durationLabel.heightAnchor.constraint(equalTo: durationLabel.widthAnchor, multiplier: 0.5),
            durationLabel.widthAnchor.constraint(equalTo: thumbnail.widthAnchor, multiplier: 0.25)
            ])
    }
}
