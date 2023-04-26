//
//  MovieInfoCell.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoCell: UICollectionViewCell {
    
    static let identifier: String = "cell"
    
    var content: RoundableView? {
        didSet {
            configureView()
            configureConstraints()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        content?.removeFromSuperview()
    }
    
    // MARK: Private Function(s)
    
    private func configureView() {
        
        guard let content = content else { return }
        contentView.addSubview(content)
    }
    
    private func configureConstraints() {
        
        guard let content = content else { return }
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
