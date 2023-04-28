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
    
    var infoStyle: InfoStyle = .backdrop
    
    // MARK: View(s)
    
    private let infoTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsCellInfo()
        label.textColor = .white
        label.text = "추천"
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsMovieTitle()
        label.textColor = .white
        label.text = "John Wick 4"
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGreen
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
    
    // MARK: Initializer
    
    convenience init(viewModel: MovieInfoViewModel, infoStyle: InfoStyle) {
        self.init(frame: .zero)
        self.infoStyle = infoStyle
        self.viewModel = viewModel
        
        makeLayoutGuide()
        configureViews()
        configureConstraints()
        applyCornerStyle()
        bindViewModel()
    }
    
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
    
    // MARK: Private Function(s)
    
    private func configureViews() {
        
        let backdropStyleViewSets: [UIView] = [backgroundImageView, infoTypeLabel, movieTitleLabel]
        let posterStyleViewSets: [UIView] = [backgroundImageView, ratingView]
        
        switch infoStyle {
        case .backdrop: backdropStyleViewSets.forEach { addSubview($0) }
        case .poster: posterStyleViewSets.forEach { addSubview($0) }
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
    
    private func configureConstraints() {
        
        addBackgroundImageConstraints()
        
        switch infoStyle {
        case .backdrop:
            addInfoTypeLabelConstraints()
            addMovieTitleLabelConstraints()
        case .poster:
            addRatingViewConstraints()
        }
    }
    
    private func addBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func addInfoTypeLabelConstraints() {
        NSLayoutConstraint.activate([
            infoTypeLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            infoTypeLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            infoTypeLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
        ])
    }
    
    private func addMovieTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            movieTitleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
    }
    
    private func addRatingViewConstraints() {
        NSLayoutConstraint.activate([
            ratingView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 5),
            ratingView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 5),
            ratingView.widthAnchor.constraint(equalToConstant: 50),
            ratingView.heightAnchor.constraint(equalTo: ratingView.widthAnchor)
        ])
    }
}

extension UIImageView {
    
    func setImage(from imagePath: String) {
        let mainHost = "https://image.tmdb.org/t/p/original"
        
        ImageCacheManager.loadImage(urlString: mainHost + imagePath) {
            self.image = $0
        }
    }
}
