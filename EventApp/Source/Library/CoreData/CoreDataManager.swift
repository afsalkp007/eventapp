//
//  CoreDataManager.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import CoreData

final  class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventApp")
        persistentContainer.loadPersistentStores(completionHandler: {_, error in
            print(error?.localizedDescription ?? "")
        })
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = Event(context: moc)
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250.0)
        let imageData = resizedImage.jpegData(compressionQuality: 1)
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchEvents() -> [Event] {
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try moc.fetch(fetchRequest)
            return events
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getEvents(_ id: NSManagedObjectID) -> Event? {
        do {
            let event = try moc.existingObject(with: id)
            return event as? Event
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
