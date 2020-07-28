//
//  AppCoordinator.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit



protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get }

    func start()
}


