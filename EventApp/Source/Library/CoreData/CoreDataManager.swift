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
    
    func save() {
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getEvent<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            let event = try moc.existingObject(with: id)
            return event as? T
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            
//            let backgroundContext = persistentContainer.newBackgroundContext()
//            backgroundContext.perform {
//                return try moc.fetch(fetchRequest)
//            }
            return try moc.fetch(fetchRequest)
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
   
}
