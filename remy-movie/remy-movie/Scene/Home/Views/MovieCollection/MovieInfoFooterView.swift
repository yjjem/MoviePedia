//
//  MovieInfoCellFooterView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoFooterView: UICollectionReusableView {
    
    static let identifier = "footer"
    static let supplementaryKind = "movie-info-footer"
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsPosterInfoTitle()
        return label
    }()
    
    private let averageRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsPosterRatingInfo()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Function(s)
    
    func set(title: String, rating: Double) {
        movieTitleLabel.text = title
        averageRatingLabel.text = rating.asAverageRatingString()
    }
    
    // MARK: Private Function(s)
    
    private func addViews() {
        
        addSubview(movieTitleLabel)
        addSubview(averageRatingLabel)
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: averageRatingLabel.topAnchor),
            averageRatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            averageRatingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            averageRatingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

private extension Double {
    
    func asAverageRatingString() -> String {
        let ratingString = "Rating ★" + String(format: "%.1f", self)
        return ratingString
    }
}
