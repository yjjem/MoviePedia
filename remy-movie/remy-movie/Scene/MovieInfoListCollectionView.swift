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
        case today
    }
    
    private var diffableDataSource: DiffableDataSource?
    
    private let cellHeight: CGFloat = 450
    private let cellSideInset: CGFloat = 30
    private let spacingBetweenCell: CGFloat = 30
    
    convenience init() {
        self.init(frame: .zero, collectionViewLayout: .init())
        
        configureCollectionDataSource()
        applyCollectionViewLayout()
        initializeDataSourceSnapshot()
    }
    
    // MARK: Private Function(s)
    
    private func makeMovieInfoCellRegistration() -> MovieInfoCellRegistration {
        
        return MovieInfoCellRegistration { cell, indexPath, itemIdentifier in
            
            let infoView = SingleMovieInfoView()
            infoView.backgroundColor = .systemBlue
            cell.content = infoView
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
    
    private func initializeDataSourceSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.today])
        snapshot.appendItems(["a", "b"], toSection: .today)
        diffableDataSource?.apply(snapshot)
    }
    
    private func makeListLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: 0,
            leading: cellSideInset,
            bottom: 0,
            trailing: cellSideInset
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(cellHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacingBetweenCell
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func applyCollectionViewLayout() {
        let listLayout = makeListLayout()
        setCollectionViewLayout(listLayout, animated: true)
    }
}
