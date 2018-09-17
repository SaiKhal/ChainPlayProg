//
//  ChainPlayCell.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class ChainPlayCell: UITableViewCell {
    
    var thumbnailIsRounded = true
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        contentView.clipsToBounds = true
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
    
    lazy var videoDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "HELLO NOW"
        return label
    }()
    
    func setupConstraints() {
        setupThumbnail()
        setupLabel()
    }
    
    func addViews() {
        contentView.addSubview(thumbnail)
        contentView.addSubview(videoDescription)
    }
    
    func setupThumbnail() {
        let margin = contentView.layoutMarginsGuide
        
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true //contentView.frame.size.height/2 * 0.2
        thumbnail.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        thumbnail.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        thumbnail.trailingAnchor.constraint(equalTo: videoDescription.leadingAnchor, constant: -15).isActive = true
    }
    
    func setupLabel() {
        videoDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoDescription.topAnchor.constraint(equalTo: thumbnail.topAnchor, constant: 10),
            videoDescription.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20)
            ])
        
    }
}
