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
    typealias SectionItem = MovieWrapper
    
    enum Section: CaseIterable {
        case categoryCollection
        case dailyTrending
        case weeklyTrending
        
        var index: Int {
            switch self {
            case .categoryCollection: return 0
            case .dailyTrending: return 1
            case .weeklyTrending: return 2
            }
        }
        
        var name: String {
            switch self {
            case .categoryCollection: return "Category"
            case .dailyTrending: return "Daily Trending"
            case .weeklyTrending: return "Weekly Trending"
            }
        }
        
        static func sectionFor(indexPath: IndexPath) -> Self {
            switch indexPath.section {
            case Self.dailyTrending.index: return .dailyTrending
            case Self.weeklyTrending.index: return .weeklyTrending
            default: return .categoryCollection
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
                resetCategoryMovieCollectionScrollPosition()
            }
        }
    }
    
    // MARK: Initializer(s)
    
    convenience init(viewModel: MovieInfoCollectionViewModel) {
        self.init(frame: .zero, collectionViewLayout: .init())
        self.viewModel = viewModel
        
        configureCollectionDataSource()
        configureCompositionalLayout()
        bindViewModel()
    }
    
    // MARK: Private Function(s)
    
    private func configureCollectionDataSource() {
        
        registerHeaderView()
        
        diffableDataSource = makeDiffableDataSource()
        
        diffableDataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MovieInfoCollectionHeaderView.identifier,
                for: indexPath
            ) as? MovieInfoCollectionHeaderView
            
            let section = Section.sectionFor(indexPath: indexPath)
            let sectionTitle = section.name
            header?.set(title: sectionTitle)
            
            return header
        }
        
        dataSource = diffableDataSource
    }
    
    private func registerHeaderView() {
        register(
            MovieInfoCollectionHeaderView.self,
            forSupplementaryViewOfKind: MovieInfoCollectionHeaderView.supplementaryKind,
            withReuseIdentifier: MovieInfoCollectionHeaderView.identifier
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
        
        return diffableDataSource
    }
    
    private func makeMovieInfoCellRegistration() -> CellRegistration {
        
        return CellRegistration { cell, indexPath, movieWrapper in
            
            let viewModel = MovieInfoViewModel(movie: movieWrapper.movie)
            let infoView = MovieInfoView(viewModel: viewModel, infoStyle: .poster)
            cell.content = infoView
        }
    }
    
    private func applySnapshot(to section: Section, appending wrappedMovies: [MovieWrapper]) {
        var snapshot = NSDiffableDataSourceSectionSnapshot<SectionItem>()
        snapshot.append(wrappedMovies)
        self.diffableDataSource?.apply(snapshot, to: section)
    }
    
    private func bindViewModel() {
        guard let viewModel else { return }
        
        viewModel.loadedCategoryMovieList = { list in
            self.applySnapshot(to: .categoryCollection, appending: list)
        }
        
        viewModel.loadedDailyTrendingMovieList = { list in
            self.applySnapshot(to: .dailyTrending, appending: list)
        }
        
        viewModel.loadedWeeklyTrendingMovieList = { list in
            self.applySnapshot(to: .weeklyTrending, appending: list)
        }
        
        viewModel.initialBind()
    }
    
    private func configureCompositionalLayout() {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let categoryMovieCollectionSection = self.makeCategoryMovieSection()
            let movieInfoWithHeaderSection = self.makeMovieInfoWithHeaderSection()
            
            switch sectionIndex {
            case Section.categoryCollection.index: return categoryMovieCollectionSection
            default: return movieInfoWithHeaderSection
            }
        }
        
        setCollectionViewLayout(layout, animated: true)
    }
    
    private func makeHeaderSupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MovieInfoCollectionHeaderView.supplementaryKind,
            alignment: .top
        )
        
        return header
    }
    
    private func makeCategoryMovieSection() -> NSCollectionLayoutSection {
        
        let ration: CGFloat = 2/3
        let width: CGFloat = 200
        let height: CGFloat = width / ration
        
        let item = makeItem(width: .absolute(width), height: .absolute(height))
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = makeHorizontalGroup(
            width: .absolute(width),
            height: .absolute(height),
            repeatingItem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    private func makeMovieInfoWithHeaderSection() -> NSCollectionLayoutSection {
        
        let header = makeHeaderSupplementaryItem()
        
        let ration: CGFloat = 2/3
        let width: CGFloat = 120
        let height: CGFloat = width / ration
        
        let item = makeItem(width: .absolute(width), height: .absolute(height))
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = makeHorizontalGroup(
            width: .absolute(width),
            height: .absolute(height),
            repeatingItem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func resetCategoryMovieCollectionScrollPosition() {
        scrollToItem(at: .init(item: 0, section: 0), at: .left, animated: true)
    }
}
