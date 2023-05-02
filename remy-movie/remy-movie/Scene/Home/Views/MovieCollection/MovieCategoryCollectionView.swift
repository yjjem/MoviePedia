//
//  MovieInfoListCollectionView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieCategoryCollectionView: UICollectionView {
    
    // MARK: Type(s)
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Movie>
    private typealias CellRegistration = UICollectionView.CellRegistration<MovieInfoCell, Movie>
    
    enum Section: CaseIterable {
        case categoryCollection
        
        var index: Int {
            switch self {
            case .categoryCollection: return 0
            }
        }
    }
    
    // MARK: Variable(s)
    
    private var diffableDataSource: DiffableDataSource?
    
    private let itemHeight: NSCollectionLayoutDimension = .absolute(200)
    private let itemCount: Int = 3
    private var itemWidth: NSCollectionLayoutDimension = .fractionalWidth(1/3)
    private let itemInset: NSDirectionalEdgeInsets = .init(
        top: 10,
        leading: 10,
        bottom: 10,
        trailing: 10
    )
    
    private let groupHeight: NSCollectionLayoutDimension = .absolute(200)
    private let groupWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0)
    private let groupInset: NSDirectionalEdgeInsets = .init(
        top: 10,
        leading: 10,
        bottom: 10,
        trailing: 10
    )
    
    private var viewModel: MovieCategoryCollectionViewModel?
    
    // MARK: Initializer(s)
    
    convenience init(viewModel: MovieCategoryCollectionViewModel) {
        self.init(frame: .zero, collectionViewLayout: .init())
        self.viewModel = viewModel
        
        configureCollectionDataSource()
        applyCollectionViewLayout()
        bindViewModel()
    }
    
    // MARK: Private Function(s)
    
    private func bindViewModel() {
        guard let viewModel else { return }
        
        viewModel.handler = { output in
            self.applySnapshot(using: output.categoryMovieList)
        }
        
        viewModel.bind()
    }
    
    private func makeMovieInfoCellRegistration() -> CellRegistration {
        
        return CellRegistration { cell, indexPath, itemIdentifier in
            
            let viewModel = MovieInfoViewModel(movie: itemIdentifier)
            let infoView = MovieInfoView(viewModel: viewModel, infoStyle: .poster)
            cell.content = infoView
        }
    }
    
    private func applySnapshot(using movieList: MovieList) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.categoryCollection])
        snapshot.appendItems(movieList)
        self.diffableDataSource?.apply(snapshot)
    }
    
    private func makeDiffableDataSource() -> DiffableDataSource {
        
        let registration = makeMovieInfoCellRegistration()
        
        let diffableDataSource: DiffableDataSource = .init(collectionView: self) {
            collectionView, indexPath, itemIdentifier in
            
            return collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        
        return diffableDataSource
    }
    
    private func configureCollectionDataSource() {
        
        diffableDataSource = makeDiffableDataSource()
        dataSource = diffableDataSource
    }
    
    private func applyCollectionViewLayout() {
        
        let item = makeItem(width: itemWidth, height: itemHeight)
        item.contentInsets = itemInset
        
        let group = makeGroup(
            width: groupWidth,
            height: groupHeight,
            repeatingItem: item,
            count: itemCount
        )
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        self.setCollectionViewLayout(layout, animated: true)
    }
    
    private func makeItem(
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension
    ) -> NSCollectionLayoutItem {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        return item
    }
    
    private func makeGroup(
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension,
        repeatingItem: NSCollectionLayoutItem,
        count: Int
    ) -> NSCollectionLayoutGroup {
        
        let groupSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: repeatingItem,
            count: count
        )
        
        return group
    }
}
