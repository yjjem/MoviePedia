//
//  MovieInfoSelectorView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol MovieInfoCollectionSelectorDelegate {
    
    func didSelectCategory(_ category: ListCategory)
}

final class MovieInfoCollectionSelectorView: UICollectionReusableView {
    
    static let reuseIdentifier: String =  "selector view"
    
    var delegate: MovieInfoCollectionSelectorDelegate?
    
    private let selectorView: UISegmentedControl = {
        let listCategoryItems = ListCategory.allNames
        let selector = UISegmentedControl(items: listCategoryItems)
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.selectedSegmentIndex = ListCategory.popular.index
        return selector
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSelectorView()
        configureActions()
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
    
    private func configureActions() {
        selectorView.addTarget(self, action: #selector(sendSelectionToDelegate), for: .valueChanged)
    }
    
    @objc
    private func sendSelectionToDelegate() {
        
        let selectedIndex = selectorView.selectedSegmentIndex
        let selectedCategory = ListCategory.allCases[selectedIndex]
        delegate?.didSelectCategory(selectedCategory)
    }
}
