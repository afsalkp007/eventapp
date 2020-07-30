
//
//  EventDetailCoordinator.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 30/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventId: NSManagedObjectID
    
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
        eventDetailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(eventDetailViewController, animated: true)
    }
}
