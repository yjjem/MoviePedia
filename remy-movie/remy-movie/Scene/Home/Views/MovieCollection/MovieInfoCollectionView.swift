//
//  MovieInfoListCollectionView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoCollectionView: UICollectionView {
    
    // MARK: Type(s)
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Movie>
    private typealias CellRegistration = UICollectionView.CellRegistration<MovieInfoCell, Movie>
    private typealias Header = MovieInfoCollectionHeaderView
    private typealias CategorySelector = MovieInfoCollectionSelectorView
    
    enum Section: CaseIterable {
        case trending
        case categoryList
    }
    
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
        
        configureCollectionView()
        bindViewModel()
    }
    
    // MARK: Private Function(s)
    
    private func bindViewModel() {
        guard let viewModel else { return }
        viewModel.delegate = self
        viewModel.loadMovieList(of: .popular)
    }
    
    private func configureCollectionView() {
        
        registerHeaderView()
        registerSelectorView()
        configureCollectionDataSource()
        applyCollectionViewLayout()
        initializeSnapshot()
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
    
    private func registerHeaderView() {
        
        let trendingSection: Section = .trending
        
        register(
            Header.self,
            forSupplementaryViewOfKind: trendingSection.elementKind,
            withReuseIdentifier: Header.reuseIdentifier
        )
    }
    
    private func registerSelectorView() {
        
        let categoryListSection: Section = .categoryList
        
        register(
            CategorySelector.self,
            forSupplementaryViewOfKind: categoryListSection.elementKind,
            withReuseIdentifier: CategorySelector.reuseIdentifier
        )
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
        
        diffableDataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            
            switch kind {
            case Section.categoryList.elementKind:
                guard let selector = collectionView.dequeueReusableSupplementaryView(
                    ofKind: Section.categoryList.elementKind,
                    withReuseIdentifier: CategorySelector.reuseIdentifier,
                    for: indexPath
                ) as? CategorySelector else { return .init() }
                
                selector.delegate = self
                
                return selector
                
            default:
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: Section.trending.elementKind,
                    withReuseIdentifier: Header.reuseIdentifier,
                    for: indexPath
                ) as? Header else { return .init() }
                
                header.setTitle(string: Section.trending.name)
                
                return header
            }
        }
        
        return diffableDataSource
    }
    
    private func configureCollectionDataSource() {
        
        diffableDataSource = makeDiffableDataSource()
        dataSource = diffableDataSource
        
        initializeSnapshot()
    }
    
    private func initializeSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections(Section.allCases)
        
        diffableDataSource?.apply(snapshot)
    }
    
    private func updateSnapshot(list: MovieList, for section: Section) {
        guard var snapshot = self.diffableDataSource?.snapshot() else { return }
        snapshot.deleteSections([section])
        snapshot.appendSections([section])
        snapshot.appendItems(list, toSection: section)
        DispatchQueue.main.async {
            self.diffableDataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func makeBigInfoSection() -> NSCollectionLayoutSection {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: Section.trending.elementKind,
            alignment: .top
        )
        
        let item = makeItem(width: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        item.contentInsets = contentsInset
        
        let group = makeGroup(
            width: .fractionalWidth(1.0),
            height: .absolute(cellHeight),
            repeatingItem: item,
            count: 1
        )
        group.interItemSpacing = contentsSpacing
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func makeSmallInfoSection() -> NSCollectionLayoutSection {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: Section.categoryList.elementKind,
            alignment: .top
        )
        
        let item = makeItem(width: .fractionalWidth(1/3), height: .absolute(200))
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let group = makeGroup(
            width: .fractionalWidth(1.0),
            height: .absolute(200),
            repeatingItem: item,
            count: 3
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
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
    
    func didLoadMovieList(list: MovieList) {
        updateSnapshot(list: list, for: .categoryList)
    }
}

extension MovieInfoCollectionView: MovieInfoCollectionSelectorDelegate {
    
    func didSelectCategory(_ category: ListCategory) {
        viewModel?.loadMovieList(of: category)
    }
}

extension MovieInfoCollectionView.Section {
    var name: String {
        switch self {
        case .trending: return "Trending"
        case .categoryList: return "Category List"
        }
    }
    
    var elementKind: String {
        switch self {
        case .trending: return "header"
        case .categoryList: return "selector"
        }
    }
    
    var index: Int {
        switch self {
        case .trending: return 1
        case .categoryList: return 2
        }
    }
}
