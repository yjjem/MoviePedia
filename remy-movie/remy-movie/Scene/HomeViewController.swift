//
//  HomeViewController.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class HomeViewController: UIViewController {
    
    private let collectionView: MovieInfoListCollectionView = {
        let collection = MovieInfoListCollectionView()
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
        collectionView.delegate = self
    }
    
    private func configureTabBarItem() {
        
        title = "Home"
        tabBarItem.image = UIImage(systemName: "house")
    }
    
    private func configureViews() {
        
        view.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate { }
