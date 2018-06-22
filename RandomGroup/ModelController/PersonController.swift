//
//  PersonController.swift
//  RandomGroup
//
//  Created by Dallin McConnell on 6/22/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    static let shared = PersonController()
    
    // MARK: - CRUD Functions
    func update(person: Person, name: String) {
        person.name = name
        save()
    }
    
    func save() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
           print("❌Error: \(error) \(error.localizedDescription) \(#function)❌")
        }
    }
    
    func delete(person: Person) {
        CoreDataStack.context.delete(person)
        save()
    }
    
    func add(name: String) {
        Person(name: name)
        save()
    }
}
