//
//  MediaToolbarView.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/17/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

final class MediaToolbarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
        setupTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize + 2)
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        return button
    }()
    
    func addSubviews() {
        [titleLabel, shareButton].forEach { addSubview($0) }
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            ])
    }
}
