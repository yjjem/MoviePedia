//
//  TrendingMovieCollectionView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class TrendingMovieCollectionView: UICollectionView, ModernCollectionView {
    
    typealias SectionItem = Movie
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, SectionItem>
    
    enum Section {
        case trending
    }
    
    var diffableDataSource: DiffableDataSource?
    
    convenience init() {
        self.init(frame: .zero, collectionViewLayout: .init())
        
        configureDataSource()
        configureLayout()
    }
    
    private func makeDiffableDataSource() -> DiffableDataSource {
        
        register(
            MovieInfoCell.self,
            forCellWithReuseIdentifier: MovieInfoCell.identifier
        )
        
        let diffableDataSource = DiffableDataSource(collectionView: self) {
            collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as? MovieInfoCell
            else {
                return .init()
            }
            
            let viewModel = MovieInfoViewModel(movie: item)
            let movieInfoView = MovieInfoView(viewModel: viewModel, infoStyle: .backdrop)
            cell.content = movieInfoView
            
            return cell
        }
        
        return diffableDataSource
    }
    
    private func configureDataSource() {
        let diffableDataSource = makeDiffableDataSource()
        self.dataSource = diffableDataSource
    }
    
    private func configureLayout() {
        
        let constant = LayoutConstants()
        
        let item = makeItem(width: constant.itemWidth, height: constant.itemHeight)
        let group = makeHorizontalGroup(
            width: constant.groupWidth,
            height: constant.groupHeight,
            repeatingItem: item,
            count: constant.itemCount
        )
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        self.setCollectionViewLayout(layout, animated: true)
    }
}

extension TrendingMovieCollectionView {
    struct LayoutConstants {
        let itemHeight: NSCollectionLayoutDimension = .absolute(200)
        let itemCount: Int = 1
        let itemWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        let itemInset : NSDirectionalEdgeInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupHeight: NSCollectionLayoutDimension = .absolute(200)
        let groupWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        let groupInset: NSDirectionalEdgeInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
}
