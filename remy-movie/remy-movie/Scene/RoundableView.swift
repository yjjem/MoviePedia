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
    }
    
    var style: PresentingStyle = .rounded {
        didSet {
            applyPresentingStyle()
        }
    }
    
    private func applyPresentingStyle() {
        switch style {
        case .full: self.layer.cornerRadius = 0
        case .rounded: self.layer.cornerRadius = 25
        }
    }
}
