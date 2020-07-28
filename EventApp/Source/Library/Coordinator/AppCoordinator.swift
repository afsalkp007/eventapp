//
//  AppCoordinator.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit



//protocol Coordinator {
//    var childCoordinators: [Coordinator] { get set }
//
//    func start()
//}

final class AppCoordinator {
    let window: UIWindow
        
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vc = EventListViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
    }
}
