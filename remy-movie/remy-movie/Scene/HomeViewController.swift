//
//  HomeViewController.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class HomeViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        configureTabBarItem()
    }
    
    private func configureTabBarItem() {
        title = "Home"
        tabBarItem.image = UIImage(systemName: "house")
    }
}
