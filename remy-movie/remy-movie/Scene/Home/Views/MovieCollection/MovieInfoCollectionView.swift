//
//  MovieInfoCollectionView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoCollectionView: UICollectionView, ModernCollectionView {
    
    // MARK: Type(s)
    
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, SectionItem>
    typealias CellRegistration = UICollectionView.CellRegistration<MovieInfoCell, SectionItem>
    typealias SectionItem = Movie
    
    enum Section: CaseIterable {
        case categoryCollection
        case trending
        
        var index: Int {
            switch self {
            case .categoryCollection: return 0
            case .trending: return 1
            }
        }
    }
    
    // MARK: Variable(s)
    
    private var viewModel: MovieInfoCollectionViewModel?
    
    var diffableDataSource: DiffableDataSource?
    
    var category: ListCategory? {
        didSet {
            if let category {
                viewModel?.category = category
            }
        }
    }
    
    // MARK: Initializer(s)
    
    convenience init(viewModel: MovieInfoCollectionViewModel) {
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
            self.applyCategoryCollectionSnapshot(using: output.categoryMovieList)
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
    
    private func applyCategoryCollectionSnapshot(using movieList: MovieList) {
        var snapshot = NSDiffableDataSourceSectionSnapshot<SectionItem>()
        snapshot.append(movieList)
        self.diffableDataSource?.apply(snapshot, to: .categoryCollection)
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
        
        let item = makeItem(width: .absolute(200), height: .absolute(300))
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = makeHorizontalGroup(
            width: .absolute(200),
            height: .fractionalWidth(1.0),
            repeatingItem: item,
            count: 1
        )
        group.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        self.setCollectionViewLayout(layout, animated: true)
    }
}
