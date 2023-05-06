//
//  MovieInfoCollectionHeaderView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

protocol CategorySelectorDelegate {
    
    func didSelectCategory(_ category: ListCategory)
}

final class MovieInfoCategorySectionHeaderView: UICollectionReusableView {
    
    static let identifier: String = "selector header"
    static let supplementaryKind: String = "category-section-header"
    
    private let categorySelector: UISegmentedControl = {
        let categorySelector = UISegmentedControl(items: ListCategory.allNames)
        categorySelector.translatesAutoresizingMaskIntoConstraints = false
        categorySelector.selectedSegmentIndex = ListCategory.popular.index
        categorySelector.backgroundColor = .systemBackground
        return categorySelector
    }()
    
    var delegate: CategorySelectorDelegate?
    
    // MARK: Override(s)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addCategorySelector()
        configureSelectorAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Function(s)
    
    private func addCategorySelector() {
        
        let inset: CGFloat = 10
        
        addSubview(categorySelector)
        
        NSLayoutConstraint.activate([
            categorySelector.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            categorySelector.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            categorySelector.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            categorySelector.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset)
        ])
    }
    
    private func configureSelectorAction() {
        
        categorySelector.addTarget(
            self,
            action: #selector(delegateSelectedCategory),
            for: .valueChanged
        )
    }
    
    @objc private func delegateSelectedCategory(_ sender: UISegmentedControl) {
        
        let selectedIndex = sender.selectedSegmentIndex
        let selectedCategory = ListCategory.category(of: selectedIndex)
        
        delegate?.didSelectCategory(selectedCategory)
    }
}
