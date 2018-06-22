//
//  CoreData.swift
//  RandomGroup
//
//  Created by Dallin McConnell on 6/22/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    static let container: NSPersistentContainer = {
        let internalContainer = NSPersistentContainer(name: "RandomGroup")
        internalContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError()
            }
        })
        return internalContainer
    }()
    static var context: NSManagedObjectContext { return container.viewContext }
}
