//
//  ImageCacheManager.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class ImageCacheManager {
    
    static let storage: NSCache<NSString, UIImage> = .init()
    
    static func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        
        let cacheKey: NSString = NSString(string: urlString)
        
        if let imageFromCache = ImageCacheManager.storage.object(forKey: cacheKey) {
            completion(imageFromCache)
            return
        }
        
        downloadImage(urlString: urlString) { image in
            
            if let image {
                storage.setObject(image, forKey: cacheKey)
                completion(image)
            }
        }
    }
    
    private static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        let concurrent = DispatchQueue.global()
        let mainQueue = DispatchQueue.main
        
        concurrent.async {
            
            guard let url = URL(string: urlString),
                  let data = try? Data(contentsOf: url)
            else {
                return
            }
            
            let downloadedImage = UIImage(data: data)
            
            mainQueue.async {
                completion(downloadedImage)
            }
        }
    }
}
