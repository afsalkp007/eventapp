
//
//  EventDetailCoordinator.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 30/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator, EventUpdatingCoordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventId: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    var onUpdateEvent = {}
    
    init(
        eventId: NSManagedObjectID,
         navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        self.eventId = eventId
    }
    
    func start() {
        let eventDetailViewController: EventDetailViewController = .instantiate()
        let eventDetailViewModel = EventDetailViewModel(eventId: eventId)
        eventDetailViewModel.coordinator = self
        onUpdateEvent = {
            eventDetailViewModel.reload()
            self.parentCoordinator?.onUpdateEvent()
        }
            
        eventDetailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(eventDetailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func onEditEvent(_ event: Event) {
        let editEventCoordinator = EditEventCoordinator(
            event: event,
            navigationController: navigationController
        )
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
