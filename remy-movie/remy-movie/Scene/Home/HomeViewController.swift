//
//  HomeViewController.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: View(s)
    
    private let categorySelector: UISegmentedControl = {
        let categorySelector = UISegmentedControl(items: ListCategory.allNames)
        categorySelector.translatesAutoresizingMaskIntoConstraints = false
        return categorySelector
    }()
    
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
        addCategorySelector()
        addMovieCategoryCollectionView()
        addCategorySelector()
    }
    
    // MARK: Private Function(s)
    
    private func configureTabBarItem() {
        
        title = "Home"
        tabBarItem.image = UIImage(systemName: "house")
    }
    
    private func addCategorySelector() {
        
        categorySelector.addTarget(self, action: #selector(updateMovieCategory), for: .valueChanged)
        categorySelector.selectedSegmentIndex = ListCategory.popular.index
        
        view.addSubview(categorySelector)
        
        NSLayoutConstraint.activate([
            categorySelector.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categorySelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categorySelector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            categorySelector.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func addMovieCategoryCollectionView() {
        
        movieCategoryCollectionView.delegate = self
        
        view.addSubview(movieCategoryCollectionView)
        
        NSLayoutConstraint.activate([
            movieCategoryCollectionView.topAnchor.constraint(equalTo: categorySelector.bottomAnchor, constant: 10),
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
