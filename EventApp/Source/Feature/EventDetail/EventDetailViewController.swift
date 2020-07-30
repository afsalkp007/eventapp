//
//  EventDetailViewController.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 30/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


final class EventDetailViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    var viewModel: EventDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onUpdate = { [weak self] in
            self?.backgroundImageView.image = self?.viewModel?.image
            //time remaining labels, event name and date label
        }
        viewModel?.viewDidLoad()
        
    }
}
