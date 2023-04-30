//
//  MovieInfoListCollectionView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoCollectionView: UICollectionView {
    
    // MARK: Type(s)
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<ListCategory, Movie>
    private typealias CellRegistration = UICollectionView.CellRegistration<MovieInfoCell, Movie>
    
    // MARK: Variable(s)
    
    private var diffableDataSource: DiffableDataSource?
    
    private let cellHeight: CGFloat = 250
    private let cellSideInset: CGFloat = 30
    private let spacingBetweenCell: CGFloat = 30
    private let contentsSpacing: NSCollectionLayoutSpacing = .fixed(8)
    private let contentsInset: NSDirectionalEdgeInsets = .init(
        top: 10,
        leading: 10,
        bottom: 10,
        trailing: 10
    )
    
    private var viewModel: MovieInfoCollectionViewModel?
    
    // MARK: Initializer(s)
    
    convenience init(viewModel: MovieInfoCollectionViewModel) {
        self.init(frame: .zero, collectionViewLayout: .init())
        self.viewModel = viewModel
        
        configureCollectionDataSource()
        applyCollectionViewLayout()
        initializeSnapshot()
        bindViewModel()
    }
    
    // MARK: Private Function(s)
    
    private func bindViewModel() {
        guard let viewModel else { return }
        viewModel.delegate = self
        viewModel.loadAllMovieLists()
    }
    
    private func makeMovieInfoCellRegistration() -> CellRegistration {
        
        return CellRegistration { cell, indexPath, itemIdentifier in
            
            let popularSection: ListCategory = .popular
            
            switch indexPath.section {
                
            case popularSection.index:
                let viewModel = MovieInfoViewModel(movie: itemIdentifier)
                let infoView = MovieInfoView(viewModel: viewModel,infoStyle: .backdrop)
                cell.content = infoView
                
            default:
                let viewModel = MovieInfoViewModel(movie: itemIdentifier)
                let infoView = MovieInfoView(viewModel: viewModel, infoStyle: .poster)
                cell.content = infoView
            }
        }
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
        
        initializeSnapshot()
    }
    
    private func initializeSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<ListCategory, Movie>()
        snapshot.appendSections(ListCategory.allCases)
        
        diffableDataSource?.apply(snapshot)
    }
    
    private func updateSnapshot(list: MovieList, for section: ListCategory) {
        guard var snapshot = self.diffableDataSource?.snapshot() else { return }
        snapshot.appendItems(list, toSection: section)
        self.diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func makeBigInfoSection() -> NSCollectionLayoutSection {
        
        let item = makeItem(width: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        item.contentInsets = contentsInset
        
        let group = makeGroup(
            width: .fractionalWidth(1.0),
            height: .absolute(cellHeight),
            items: [item]
        )
        group.interItemSpacing = contentsSpacing
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func makeSmallInfoSection() -> NSCollectionLayoutSection {
        
        let item = makeItem(width: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        item.contentInsets = contentsInset
        
        let group = makeGroup(width: .absolute(180), height: .absolute(cellHeight), items: [item])
        group.interItemSpacing = contentsSpacing
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
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
        items: [NSCollectionLayoutItem]
    ) -> NSCollectionLayoutGroup {
        
        let groupSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
        
        return group
    }
    
    private func applyCollectionViewLayout() {
        
        let popularSection: ListCategory = .popular
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            switch sectionIndex {
            case popularSection.index:
                return self.makeBigInfoSection()
            default:
                return self.makeSmallInfoSection()
            }
        }
        
        setCollectionViewLayout(layout, animated: true)
    }
}

// MARK: Extension(s)

extension MovieInfoCollectionView: MovieInfoCollectionDelegate {
    
    func didLoadMovieList(list: MovieList, of category: ListCategory) {
        updateSnapshot(list: list, for: category)
    }
}
