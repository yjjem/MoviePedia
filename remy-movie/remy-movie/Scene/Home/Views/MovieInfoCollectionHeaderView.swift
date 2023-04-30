//
//  MovieCollectionHeaderView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class MovieInfoCollectionHeaderView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAsCellInfo()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(string: String) {
        label.text = string
    }
    
    private func addLabel() {
        
        addSubview(label)
        
        let labelInset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: labelInset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -labelInset),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: labelInset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -labelInset),
        ])
    }
}
