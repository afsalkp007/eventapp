//
//  SceneDelegate.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        
        
        
    }

}

