//
//  HomeViewController.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class HomeViewController: UIViewController {
    
    private let movieInfoCollectionView: MovieInfoCollectionView = {
        let manager = NetworkManager(session: .init(configuration: .default))
        let service = MovieService(manger: manager)
        let useCase = MovieInfoUseCase(service: service)
        let viewModel = MovieInfoCollectionViewModel(useCase: useCase)
        let collection = MovieInfoCollectionView(viewModel: viewModel)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func loadView() {
        super.loadView()
        
        configureTabBarItem()
        configureViews()
        configureConstraints()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        movieInfoCollectionView.delegate = self
    }
    
    private func configureTabBarItem() {
        
        title = "Home"
        tabBarItem.image = UIImage(systemName: "house")
    }
    
    private func configureViews() {
        
        view.addSubview(movieInfoCollectionView)
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            movieInfoCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieInfoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieInfoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieInfoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate { }
