//
//  HomeViewController.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: View(s)
    
    private let movieCategoryCollectionView: MovieInfoCollectionView = {
        let manager = NetworkManager(session: .init(configuration: .default))
        let service = MovieService(manger: manager)
        let useCase = MovieInfoUseCase(service: service)
        let viewModel = MovieInfoCollectionViewModel(useCase: useCase)
        let collection = MovieInfoCollectionView(viewModel: viewModel)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        configureTabBarItem()
        addMovieCategoryCollectionView()
    }
    
    // MARK: Private Function(s)
    
    private func configureTabBarItem() {
        tabBarItem.image = UIImage(systemName: "house")
    }
    
    
    private func addMovieCategoryCollectionView() {
        
        movieCategoryCollectionView.delegate = self
        
        view.addSubview(movieCategoryCollectionView)
        
        NSLayoutConstraint.activate([
            movieCategoryCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            movieCategoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func updateMovieCategory(_ selector: UISegmentedControl) {
        let selectedIndex = selector.selectedSegmentIndex
        let selectedCategory = ListCategory.category(of: selectedIndex)
        movieCategoryCollectionView.category = selectedCategory
    }
}

// MARK: Extension(s)

extension HomeViewController: UICollectionViewDelegate { }
