//
//  MovieView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoView: RoundableView {
    
    // MARK: View(s)
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsMovieTitle()
        label.textColor = .white
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let layoutGuide: UILayoutGuide = {
        return UILayoutGuide()
    }()
    
    private var viewModel: MovieInfoViewModel?
    
    // MARK: Initializer(s)
    
    convenience init(viewModel: MovieInfoViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        
        addBackgroundImageView()
        applyCornerStyle()
        bindViewModel()
    }
    
    // MARK: Private Function(s)
    
    private func bindViewModel() {
        guard let viewModel else { return }
        movieTitleLabel.text = viewModel.title
        
        if let posterPath = viewModel.posterPath {
            backgroundImageView.setImage(from: posterPath)
        }
    }
    
    private func addBackgroundImageView() {
        
        addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
