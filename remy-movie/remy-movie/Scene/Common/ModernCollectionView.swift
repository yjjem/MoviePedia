//
//  ModernCollectionView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

protocol ModernCollectionView: UICollectionView {
    associatedtype Section: Sendable, Hashable
    associatedtype SectionItem: Sendable, Hashable
    associatedtype DiffableDatatSource = UICollectionViewDiffableDataSource<Section, SectionItem>
    
    var diffableDataSource: DiffableDatatSource { get }
}

extension ModernCollectionView {
    
    func makeItem(
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension
    ) -> NSCollectionLayoutItem {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        return item
    }
    
    func makeHorizontalGroup(
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
    
    func makeVerticalGroup(
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension,
        repeatingItem: NSCollectionLayoutItem,
        count: Int
    ) -> NSCollectionLayoutGroup {
        
        let groupSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: repeatingItem,
            count: count
        )
        
        return group
    }
}
