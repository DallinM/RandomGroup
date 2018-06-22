//
//  CoreData.swift
//  RandomGroup
//
//  Created by Dallin McConnell on 6/22/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RandomGroup")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}
//enum CoreDataStack {
//    static let container: NSPersistentContainer = {
//        let internalContainer = NSPersistentContainer(name: "RandomGroup")
//        internalContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error {
//                fatalError()
//            }
//        })
//        return internalContainer
//    }()
//    static var context: NSManagedObjectContext { return container.viewContext }
//}

//struct CoreDataStack {
//
//    static let container: NSPersistentContainer = {
//
//        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
//        let container = NSPersistentContainer(name: appName)
//        container.loadPersistentStores() { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//        return container
//    }()
//
//    static var context: NSManagedObjectContext { return container.viewContext }
//}
