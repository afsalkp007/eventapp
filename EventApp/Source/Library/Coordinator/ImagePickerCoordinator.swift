//
//  ImagePickerCoordinator.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 29/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


final class ImagePickerCoordinator: NSObject, Coordinator  {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var onFinishPicking: (UIImage) -> Void = {_ in }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController.present(imagePickerController, animated: true)
    }
}

extension ImagePickerCoordinator: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            onFinishPicking( image)
        }
        parentCoordinator?.childDidFinish(self)
    }
}
