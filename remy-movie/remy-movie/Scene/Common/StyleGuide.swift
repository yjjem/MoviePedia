//
//  StyleGuide.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

private extension CGFloat {
    static let mainTitleTextSize: CGFloat = 36.0
    static let subTitleTextSize: CGFloat = 28.0
    static let headerTitleTextSize: CGFloat = 24.0
    static let posterInfoTitleTextSize: CGFloat = 14.0
    static let posterInfoRatingInfoTextSize: CGFloat = 12.0
}

extension UILabel {
    
    func configureAsMovieTitle() {
        configure(size: .mainTitleTextSize, alignment: .left, lines: 2, weight: .bold)
    }
    
    func configureAsCellInfo() {
        configure(size: .subTitleTextSize, alignment: .left, lines: 1, weight: .regular)
    }
    
    func configureAsHeaderTitle() {
        configure(size: .headerTitleTextSize, alignment: .left, lines: 1, weight: .semibold)
    }
    
    func configureAsPosterInfoTitle() {
        configure(size: .posterInfoTitleTextSize, alignment: .left, lines: 2, weight: .regular)
    }
    
    func configureAsPosterRatingInfo() {
        configure(
            size: .posterInfoRatingInfoTextSize,
            alignment: .left,
            lines: 1,
            weight: .light,
            color: .secondaryLabel
        )
    }
    
    private func configure(
        size: CGFloat,
        alignment: NSTextAlignment,
        lines: Int,
        weight: UIFont.Weight,
        color: UIColor = .label
    ) {
        font = UIFont.systemFont(ofSize: size, weight: weight)
        textAlignment = alignment
        numberOfLines = lines
        textColor = color
    }
}
