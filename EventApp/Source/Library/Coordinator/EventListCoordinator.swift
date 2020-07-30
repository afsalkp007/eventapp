//
//  EventListCoordinator.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var onSaveEvent = {}
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListViewController: EventListViewController = .instantiate()
        let eventlistViewModel = EventListViewModel()
        eventlistViewModel.coordinator = self
        onSaveEvent = eventlistViewModel.reload
        eventListViewController.viewModel = eventlistViewModel
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func didFinishChild(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
             return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
