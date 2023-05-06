//
//  UIImageView + setImage.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

extension UIImageView {
    
    func setImage(from imagePath: String) {
        
        let imageHost = "https://image.tmdb.org/t/p/original"
        
        startLoadingAnimation { layer in
            ImageCacheManager.loadImage(urlString: imageHost + imagePath) { [weak self] image in
                
                self?.image = image
                layer.removeFromSuperlayer()
            }
        }
    }
}

extension UIImageView {
    
    func startLoadingAnimation(_ completion: @escaping (CAGradientLayer) -> Void) {
        
        let gradientLayer = CAGradientLayer()
        let silverGradient : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        gradientLayer.colors = [UIColor.clear.cgColor, silverGradient, UIColor.clear.cgColor]
        gradientLayer.startPoint = .init(x: 0, y: 1)
        gradientLayer.endPoint = .init(x: 1, y: 0)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = .init(x: 0, y: 0, width: 450, height: 800)
        
        layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.duration = 0.9
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity

        gradientLayer.add(animation, forKey: "asdf ")
        
        completion(gradientLayer)
    }
}
