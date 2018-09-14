//
//  ChainPlayCell.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/14/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class ChainPlayCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        iv.contentMode = .scaleAspectFit
        iv.image = nil
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
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: 20).isActive = true //contentView.frame.size.height/2 * 0.2
        thumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: 20).isActive = true
        thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: 20).isActive = true
        
        thumbnail.trailingAnchor.constraint(equalTo: videoDescription.trailingAnchor,
                                            constant: 20).isActive = true
    }
    
    func setupLabel() {
        videoDescription.translatesAutoresizingMaskIntoConstraints = false
        videoDescription.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20).isActive = true
        videoDescription.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 20).isActive = true
        videoDescription.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 20).isActive = true
         videoDescription.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20).isActive = true
        
    }
}
