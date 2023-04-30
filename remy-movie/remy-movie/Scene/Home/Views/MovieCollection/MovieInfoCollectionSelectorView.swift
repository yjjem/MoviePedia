//
//  MovieInfoSelectorView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoCollectionSelectorView: UICollectionReusableView {
    
    private let selectorView: UISegmentedControl = {
        let listCategoryItems = ListCategory.allNames
        let selector = UISegmentedControl(items: listCategoryItems)
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSelectorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSelectorView() {
        
        let inset: Double = 10
        
        addSubview(selectorView)
        
        NSLayoutConstraint.activate([
            selectorView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            selectorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            selectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            selectorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset)
        ])
    }
}
