//
//  MovieInfoCollectionHeaderView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class MovieInfoCollectionSectionHeaderView: UICollectionReusableView {
    
    static let identifier: String = "header"
    static let supplementaryKind: String = "section-header"
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsHeaderTitle()
        return label
    }()
    
    // MARK: Override(s)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addHeaderTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Function(s)
    
    func set(title: String) {
        headerTitleLabel.text = title
    }
    
    // MARK: Private Function(s)
    
    private func addHeaderTitleLabel() {
        
        addSubview(headerTitleLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            headerTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
