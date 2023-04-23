//
//  MovieInfoCell.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoCell: UICollectionViewCell {
    
    var content: RoundableView? {
        didSet {
            configureView()
            configureConstraints()
        }
    }
    
    private func configureView() {
        guard let content = content else { return }
        contentView.addSubview(content)
    }
    
    private func configureConstraints() {
        guard let content = content else { return }
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
