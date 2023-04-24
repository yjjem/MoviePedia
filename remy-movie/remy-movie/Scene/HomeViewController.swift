//
//  HomeViewController.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    enum Section {
        case first
        case second
    }
    
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: .init()
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .systemGray3
        return collection
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>?
    
    override func loadView() {
        super.loadView()
        
        configureTabBarItem()
        configureViews()
        configureConstraints()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        
        configureCollectionDataSource()
        applySnapshot()
        applyCollectionViewLayout()
        collectionView.delegate = self
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(450))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 9

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func applyCollectionViewLayout() {
        let compositionalLayout = createCollectionViewLayout()
        collectionView.setCollectionViewLayout(compositionalLayout, animated: true)
    }
    
    private func applySnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.first, .second])
        snapshot.appendItems(["a", "b"])
        snapshot.appendItems(["c","d"], toSection: .first)
        dataSource?.apply(snapshot)
    }
    
    private func makeCellRegistration() -> UICollectionView.CellRegistration<MovieInfoCell, String> {
        
        return UICollectionView.CellRegistration<MovieInfoCell, String> {
            cell, indexPath, itemIdentifier in
            
            let infoView = SingleMovieInfoView()
            cell.content = infoView
            cell.backgroundColor = .systemGray6

            // TODO: Configure Cell
        }
    }
    
    private func configureCollectionDataSource() {
        
        let registration = makeCellRegistration()
        dataSource = .init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        collectionView.dataSource = dataSource
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
