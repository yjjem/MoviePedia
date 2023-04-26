//
//  RoundableView.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

class RoundableView: UIView {
    
    enum CornerStyle {
        case full
        case rounded
        
        var radius: CGFloat {
            switch self {
            case .full: return 0
            case .rounded: return 21.65
            }
        }
    }
    
    var cornerStyle: CornerStyle = .rounded {
        didSet {
            applyCornerStyle()
        }
    }
    
    func applyCornerStyle() {
        layer.cornerRadius = cornerStyle.radius
        layer.masksToBounds = true
    }
}
