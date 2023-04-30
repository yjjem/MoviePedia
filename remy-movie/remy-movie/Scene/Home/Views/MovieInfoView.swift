//
//  MovieView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoView: RoundableView {
    
    enum InfoStyle {
        case backdrop
        case poster
    }
    
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
    
    private let ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 25
        return view
    }()
    
    private let layoutGuide: UILayoutGuide = {
        return UILayoutGuide()
    }()
    
    private var viewModel: MovieInfoViewModel?
    private var infoStyle: InfoStyle = .backdrop
    
    // MARK: Initializer(s)
    
    convenience init(viewModel: MovieInfoViewModel, infoStyle: InfoStyle) {
        self.init(frame: .zero)
        self.infoStyle = infoStyle
        self.viewModel = viewModel
        
        makeLayoutGuide()
        configureViews()
        applyCornerStyle()
        bindViewModel()
    }
    
    // MARK: Private Function(s)
    
    private func bindViewModel() {
        guard let viewModel else { return }
        movieTitleLabel.text = viewModel.title
        
        switch infoStyle {
        case .backdrop:
            backgroundImageView.setImage(from: viewModel.backdropPath!)
        case .poster:
            backgroundImageView.setImage(from: viewModel.posterPath!)
        }
    }
    
    private func makeLayoutGuide() {
        
        let guideInset: CGFloat = 20
        
        addLayoutGuide(layoutGuide)
        
        NSLayoutConstraint.activate([
            layoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: guideInset),
            layoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -guideInset),
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: guideInset),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -guideInset)
        ])
    }
    
    private func configureViews() {
        
        if infoStyle == .backdrop {
            configureAsBackdropInfo()
        }
        
        if infoStyle == .poster {
            configureAsPosterInfo()
        }
    }
    
    private func configureAsBackdropInfo() {
        addBackgroundImageView()
        addMovieTitleLabelView()
    }
    
    private func configureAsPosterInfo() {
        addBackgroundImageView()
        addRatingViewView()
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
    
    private func addMovieTitleLabelView() {
        
        addSubview(movieTitleLabel)
        
        NSLayoutConstraint.activate([
            movieTitleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
    }
    
    private func addRatingViewView() {
        
        addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            ratingView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 5),
            ratingView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 5),
            ratingView.widthAnchor.constraint(equalToConstant: 50),
            ratingView.heightAnchor.constraint(equalTo: ratingView.widthAnchor)
        ])
    }
}
