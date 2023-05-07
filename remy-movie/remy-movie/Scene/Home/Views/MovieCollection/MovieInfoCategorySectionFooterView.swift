//
//  MovieInfoCategorySectionFooterView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoCategorySectionFooterView: UICollectionReusableView {
    
    static let identifier: String = "category footer"
    static let supplementaryKind: String = "category-section-footer"
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsMovieTitle()
        label.textAlignment = .center
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.pageIndicatorTintColor = .systemGray
        control.currentPageIndicatorTintColor = .systemBlue
        return control
    }()
    
    // MARK: Override(s)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Function(s)
    
    func set(title: String) {
        movieTitleLabel.text = title
    }
    
    func set(pageControlPageCount: Int) {
        pageControl.numberOfPages = pageControlPageCount
    }
    
    // MARK: Private Function(s)
    
    private func configureViews() {
        
        let inset: CGFloat = 10

        addSubview(movieTitleLabel)
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            movieTitleLabel.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -inset),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            pageControl.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
}

extension MovieInfoCategorySectionFooterView: MovieInfoCollectionCategorySectionPagingDelegate {
    
    func didPageTo(page: Int, with item: Movie) {
        pageControl.currentPage = page
        movieTitleLabel.text = item.title
    }
}
