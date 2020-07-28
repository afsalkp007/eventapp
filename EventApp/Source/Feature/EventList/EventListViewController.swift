//
//  EventListViewController.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButton = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedRightBarButton))
        barButton.tintColor = .primary
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc private func tappedRightBarButton() {
        print(#function)
    }
}


