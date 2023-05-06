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
    }
    
    // MARK: Variable(s)
    
    var diffableDataSource: DiffableDataSource?
    
    var category: ListCategory? {
        didSet {
            if let category {
                viewModel?.category = category
                resetCategoryMovieCollectionScrollPosition()
            }
        }
    }
    
    private var viewModel: MovieInfoCollectionViewModel?
    
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
        
        registerSectionHeaderView()
        registerMovieInfoCellFooterView()
        registerMovieCategorySelectorHeaderView()
        
        diffableDataSource = makeDiffableDataSource()
        
        guard let diffableDataSource else { return }
        
        diffableDataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            
            return self.dequeueSupplementaryViewFor(
                collectionView: collectionView,
                kind: kind,
                indexPath: indexPath
            )
        }
        
        dataSource = diffableDataSource
    }
    
    private func dequeueSupplementaryViewFor(
        collectionView: UICollectionView,
        kind: String,
        indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
            
        case MovieInfoCategorySectionHeaderView.supplementaryKind:
            
            guard let selectorHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: MovieInfoCategorySectionHeaderView.supplementaryKind,
                withReuseIdentifier: MovieInfoCategorySectionHeaderView.identifier,
                for: indexPath
            ) as? MovieInfoCategorySectionHeaderView
            else {
                fatalError("Failed to dequeue selector header")
            }
            
            selectorHeader.delegate = self
            
            return selectorHeader
            
        case MovieInfoCollectionSectionHeaderView.supplementaryKind:
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MovieInfoCollectionSectionHeaderView.identifier,
                for: indexPath
            ) as? MovieInfoCollectionSectionHeaderView
            else {
                fatalError("Failed to dequeue section header")
            }
            
            let section = Section.sectionFor(indexPath: indexPath)
            let sectionTitle = section.name
            header.set(title: sectionTitle)
            
            return header
            
        case MovieInfoFooterView.supplementaryKind:
            
            guard let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MovieInfoFooterView.identifier,
                for: indexPath
            ) as? MovieInfoFooterView
            else {
                fatalError("Failed to dequeue item footer")
            }
            
            if let sectionItem = diffableDataSource?.itemIdentifier(for: indexPath) {
                let movie = sectionItem.movie
                footer.set(title: movie.title, rating: movie.voteAverage)
            }
            
            return footer
            
        default:
            fatalError("Unrecognized supplementary view kind ")
        }
        
    }
    
    private func registerSectionHeaderView() {
        register(
            MovieInfoCollectionSectionHeaderView.self,
            forSupplementaryViewOfKind: MovieInfoCollectionSectionHeaderView.supplementaryKind,
            withReuseIdentifier: MovieInfoCollectionSectionHeaderView.identifier
        )
    }
    
    private func registerMovieInfoCellFooterView() {
        register(
            MovieInfoFooterView.self,
            forSupplementaryViewOfKind: MovieInfoFooterView.supplementaryKind,
            withReuseIdentifier: MovieInfoFooterView.identifier
        )
    }
    
    private func registerMovieCategorySelectorHeaderView() {
        register(
            MovieInfoCategorySectionHeaderView.self,
            forSupplementaryViewOfKind: MovieInfoCategorySectionHeaderView.supplementaryKind,
            withReuseIdentifier: MovieInfoCategorySectionHeaderView.identifier
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
    
    // MARK: Layout
    
    private func configureCompositionalLayout() {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let categoryMovieCollectionSection = self.makeSelectableCategorySection()
            let movieInfoWithHeaderSection = self.makePosterInfoSection()
            
            switch sectionIndex {
            case Section.categoryCollection.index: return categoryMovieCollectionSection
            default: return movieInfoWithHeaderSection
            }
        }
        
        setCollectionViewLayout(layout, animated: true)
    }
    
    private func makeCategorySectionHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MovieInfoCategorySectionHeaderView.supplementaryKind,
            alignment: .top
        )
        
        header.pinToVisibleBounds = true
        
        return header
    }
    
    private func makeCollectionSectionHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MovieInfoCollectionSectionHeaderView.supplementaryKind,
            alignment: .top
        )
        
        return header
    }
    
    private func makeMovieFooterItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let footerWidth: CGFloat = 120
        let footerHeight: CGFloat = 50
        
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .absolute(footerWidth),
            heightDimension: .estimated(footerHeight)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: MovieInfoFooterView.supplementaryKind,
            alignment: .bottom
        )
        
        return footer
    }
    
    private func makeSelectableCategorySection() -> NSCollectionLayoutSection {
        
        let posterRatio: CGFloat = 2/3
        let posterWidth: CGFloat = 200
        let posterHeight: CGFloat = posterWidth / posterRatio
        
        let categorySelectableHeader = makeCategorySectionHeaderItem()
        
        let posterItem: NSCollectionLayoutItem = makeItem(
            width: .absolute(posterWidth),
            height: .absolute(posterHeight)
        )
        
        let group: NSCollectionLayoutGroup = makeHorizontalGroup(
            width: .absolute(posterWidth),
            height: .absolute(posterHeight),
            repeatingItem: posterItem,
            count: 1
        )
        
        let sectionInset = NSDirectionalEdgeInsets(
            top: 40,
            leading: .zero,
            bottom: 40,
            trailing: .zero
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 20
        section.boundarySupplementaryItems = [categorySelectableHeader]
        
        return section
    }
    
    private func makePosterInfoSection() -> NSCollectionLayoutSection {
        
        let posterRatio: CGFloat = 2/3
        let posterWidth: CGFloat = 120
        let posterHeight: CGFloat = posterWidth / posterRatio
        
        let sectionHeader = makeCollectionSectionHeaderItem()
        let posterFooter = makeMovieFooterItem()
        
        let posterFooterHeight: CGFloat = posterFooter.layoutSize.heightDimension.dimension
        let groupInnerSpacing: CGFloat = 8
        let groupHeight: CGFloat = posterHeight + groupInnerSpacing + posterFooterHeight
        
        let item: NSCollectionLayoutItem = makeItem(
            width: .absolute(posterWidth),
            height: .absolute(posterHeight)
        )
        
        let group: NSCollectionLayoutGroup = makeHorizontalGroup(
            width: .absolute(posterWidth),
            height: .absolute(groupHeight),
            repeatingItem: item,
            count: 1
        )
        group.supplementaryItems = [posterFooter]
        
        let sectionInset = NSDirectionalEdgeInsets(
            top: .zero,
            leading: 20,
            bottom: .zero,
            trailing: 20
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]
        section.interGroupSpacing = 20
        
        return section
    }
    
    private func resetCategoryMovieCollectionScrollPosition() {
        let startPosition = IndexPath(item: 0, section: 0)
        scrollToItem(at: startPosition, at: .left, animated: true)
    }
}

// MARK: Extension(s)

extension MovieInfoCollectionView.Section {
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

extension MovieInfoCollectionView: CategorySelectorDelegate {
    
    func didSelectCategory(_ category: ListCategory) {
        viewModel?.category = category
        
        let initialOffset = CGPoint(x: 0, y: 0)
        let firstSectionFirstItem = IndexPath(row: 0, section: 0)
        
        if contentOffset != initialOffset {
            setContentOffset(.init(x: 0, y: 0), animated: true)
        }
        
        scrollToItem(at: firstSectionFirstItem, at: .top, animated: true)
    }
}
