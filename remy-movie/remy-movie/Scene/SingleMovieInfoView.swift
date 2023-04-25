//
//  SingleMovieView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class SingleMovieInfoView: RoundableView {
    
    private let infoTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsCellInfo()
        label.text = "오늘의 영화"
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsMovieTitle()
        label.text = "John Wick 4"
        return label
    }()
    
    private let layoutGuide: UILayoutGuide = {
        return UILayoutGuide()
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        configureViews()
        configureConstraints()
        applyPresentingStyle()
    }
    
    private func configureViews() {
        
        let views: [UIView] = [infoTypeLabel, movieTitleLabel]
        views.forEach { addSubview($0) }
        addLayoutGuide(layoutGuide)
    }
    
    private func configureConstraints() {
        
        let guideInset: CGFloat = 20
        NSLayoutConstraint.activate([
            layoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: guideInset),
            layoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -guideInset),
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: guideInset),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -guideInset)
        ])
        
        NSLayoutConstraint.activate([
            infoTypeLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            infoTypeLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            infoTypeLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
    }
}
