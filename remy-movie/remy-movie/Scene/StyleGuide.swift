//
//  StyleGuide.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

private extension CGFloat {
    static let mainTitleTextSize: CGFloat = 36.0
    static let subTitleTextSize: CGFloat = 28.0
}

extension UILabel {
    
    func configureAsMovieTitle() {
        configure(size: .mainTitleTextSize, alignment: .left, lines: 2, weight: .bold)
    }
    
    func configureAsCellInfo() {
        configure(size: .subTitleTextSize, alignment: .left, lines: 1, weight: .regular)
    }
    
    private func configure(
        size: CGFloat,
        alignment: NSTextAlignment,
        lines: Int,
        weight: UIFont.Weight
    ) {
        font = UIFont.systemFont(ofSize: size, weight: weight)
        textAlignment = alignment
        numberOfLines = lines
        lineBreakMode = .byTruncatingTail
    }
}
