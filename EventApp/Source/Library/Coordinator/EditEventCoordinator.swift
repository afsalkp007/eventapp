//
//  EditEventCoordinator.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 02/08/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import CoreData

protocol EventUpdatingCoordinator {
    var onUpdateEvent: () -> Void { get }
}

final class EditEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var completion: (UIImage) -> Void = { _ in }
    private let event: Event
    
    var parentCoordinator: (EventUpdatingCoordinator & Coordinator)?
    
    init(
        event: Event,
        navigationController: UINavigationController
    ) {
        self.event = event
        self.navigationController = navigationController
    }
    
    func start() {
        let editEventViewController: EditEventViewController = .instantiate()
        let editEventViewModel = EditEventViewModel(event: event, cellBuilder: CellBuilder())
        editEventViewModel.coordinator = self
        editEventViewController.viewModel = editEventViewModel
        navigationController.pushViewController(editEventViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishUpdateEvent() {
        parentCoordinator?.onUpdateEvent()
        navigationController.popViewController(animated: true)
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            completion(image)
            self.navigationController.dismiss(animated: true)
        }
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func didFinishPicking(_ image: UIImage) {
        completion(image)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
