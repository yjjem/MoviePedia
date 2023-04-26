//
//  MovieInfoListCollectionView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoListCollectionView: UICollectionView {
    
    // MARK: Type(s)
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, String>
    private typealias CellRegistration = UICollectionView.CellRegistration<MovieInfoCell, String>
    
    private enum Section: String {
        case popular = "Popular"
        case topRated = "Top Rated"
        case nowPlaying = "Now Playing"
        case trailer = "Trailer"
        case upcoming = "Upcoming"
        
        var index: Int {
            switch self {
            case .popular: return 0
            case .topRated: return 1
            case .nowPlaying: return 2
            case .trailer: return 3
            case .upcoming: return 4
            }
        }
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
    
    // MARK: Initializer(s)
    
    convenience init() {
        self.init(frame: .zero, collectionViewLayout: .init())
        
        configureCollectionDataSource()
        applyCollectionViewLayout()
        initializeDataSourceSnapshot()
    }
    
    // MARK: Private Function(s)
    
    private func makeMovieInfoCellRegistration() -> CellRegistration {
        
        return CellRegistration { cell, indexPath, itemIdentifier in
            
            let infoView = MovieInfoView(infoStyle: .poster)
            infoView.applyCornerStyle()
            infoView.infoStyle = .poster
            
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
        snapshot.appendSections([.popular, .topRated, .nowPlaying, .trailer, .upcoming])
        snapshot.appendItems(["a", "b","c","d","e","f"], toSection: .popular)
        snapshot.appendItems(["g", "h","i","j","k","q"], toSection: .upcoming)
        snapshot.appendItems(["a51", "11b2","c24","d112233","23","12"], toSection: .topRated)
        snapshot.appendItems(["a321", "2b2","12c4","d1233","223","11"], toSection: .nowPlaying)
        snapshot.appendItems(["56a1", "bssdfg2"], toSection: .trailer)
        
        diffableDataSource?.apply(snapshot)
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
        
        let popularSection: Section = .popular
        let trailerSection: Section = .trailer
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            switch sectionIndex {
            case popularSection.index, trailerSection.index:
                return self.makeBigInfoSection()
            default:
                return self.makeSmallInfoSection()
            }
        }
        
        setCollectionViewLayout(layout, animated: true)
    }
}
