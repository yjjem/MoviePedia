//
//  MovieInfoListCollectionView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoListCollectionView: UICollectionView {
    
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, String>
    typealias MovieInfoCellRegistration = UICollectionView.CellRegistration<MovieInfoCell, String>
    
    enum Section {
        case first
        case second
    }
    
    private var diffableDataSource: DiffableDataSource?
    
    convenience init() {
        self.init(frame: .zero, collectionViewLayout: .init())
        
        configureCollectionDataSource()
        applyCollectionViewLayout()
        initializeDataSourceSnapshot()
    }
    
    private func makeMovieInfoCellRegistration() -> MovieInfoCellRegistration {
        
        return MovieInfoCellRegistration {
            cell, indexPath, itemIdentifier in
            
            let infoView = SingleMovieInfoView()
            cell.content = infoView
            cell.backgroundColor = .systemGray6
            
            // TODO: Configure Cell
        }
    }
    
    private func configureCollectionDataSource() {
        
        let registration = makeMovieInfoCellRegistration()
        
        diffableDataSource = .init(collectionView: self) {
            collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        
        self.dataSource = diffableDataSource
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
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
        setCollectionViewLayout(compositionalLayout, animated: true)
    }
    
    private func initializeDataSourceSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.first, .second])
        snapshot.appendItems(["a", "b"])
        snapshot.appendItems(["c","d"], toSection: .first)
        diffableDataSource?.apply(snapshot)
    }
}
