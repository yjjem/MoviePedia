//
//  UIImageView + setImage.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

extension UIImageView {
    
    func setImage(from imagePath: String) {
        
        let imageHost = "https://image.tmdb.org/t/p/original"
        
        ImageCacheManager.loadImage(urlString: imageHost + imagePath) {
            self.image = $0
        }
    }
}
