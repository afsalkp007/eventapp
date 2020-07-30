//
//  EventDetailViewModel.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 30/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import CoreData

final class EventDetailViewModel {
    
    private let coreDataManager: CoreDataManager
    private let eventId: NSManagedObjectID
    private var event: Event?
    var onUpdate = {}
    
    var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    init(eventId: NSManagedObjectID, coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
        self.eventId = eventId
    }
    
    func viewDidLoad() {
        event = coreDataManager.getEvents(eventId)
        onUpdate()
    }
}
