//
//  EventListViewController.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButton = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventButton))
        barButton.tintColor = .primary
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = viewModel?.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc private func tappedAddEventButton() {
        viewModel?.tappedAddEvent()
    }
}

//extension EventListViewController: Storyboarded {}


