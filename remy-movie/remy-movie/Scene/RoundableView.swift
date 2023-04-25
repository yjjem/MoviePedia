//
//  RoundableView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

class RoundableView: UIView {
    
    enum PresentingStyle {
        case full
        case rounded
        
        var cornerRadius: CGFloat {
            switch self {
            case .full: return 0
            case .rounded: return 21.65
            }
        }
    }
    
    var style: PresentingStyle = .rounded {
        didSet {
            applyPresentingStyle()
        }
    }
    
    func applyPresentingStyle() {
        layer.cornerRadius = style.cornerRadius
    }
}
