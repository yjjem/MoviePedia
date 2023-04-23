//
//  SingleMovieView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class SingleMovieInfoView: RoundableView {
    
    private let infoTypeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    convenience init() {
        self.init()
        
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        
        let views: [UIView] = [infoTypeLabel, movieTitleLabel]
        views.forEach { addSubview($0) }
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            infoTypeLabel.topAnchor.constraint(equalTo: topAnchor),
            infoTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
