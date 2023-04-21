//
//  SceneDelegate.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let home = HomeViewController()
        let sceneList: [UIViewController] = [home]
        
        let rootViewController = UITabBarController()
        rootViewController.modalPresentationStyle = .fullScreen
        rootViewController.tabBar.backgroundColor = .white
        rootViewController.setViewControllers(sceneList, animated: true)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootViewController
        window?.backgroundColor = .systemGray6
        window?.makeKeyAndVisible()
    }
}

