//
//  GroupTableViewController.swift
//  RandomGroup
//
//  Created by Dallin McConnell on 6/22/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit
import CoreData


class GroupTableViewController: UITableViewController {
    

    var person: Person?
    
    let fetchRequestController: NSFetchedResultsController<Person> = {
        let internalFetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        internalFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let controller = NSFetchedResultsController(fetchRequest: internalFetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try controller.performFetch()
        } catch let error {
            print("baaaaad \(error)")
        }
        return controller
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRequestController.delegate = self
        do {
            try fetchRequestController.performFetch()
        } catch {
            print("Error fetching from the fetchRequestController \(error.localizedDescription)")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let number = fetchRequestController.fetchedObjects?.count else { return 2 }
        var newNumber = number / 2
        if newNumber % 2 != 0 {
            newNumber += 1
        }
        return newNumber
//        return fetchRequestController.fetchedObjects?.count ?? 0
//        return (fetchRequestController.fetchedObjects?.count)! / 2 ?? 0
      //  return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRequestController.fetchedObjects?.count ?? 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)

        guard let people = fetchRequestController.fetchedObjects else { return UITableViewCell() }
        let person = people[indexPath.row]
        cell.textLabel?.text = person.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let person = fetchRequestController.fetchedObjects?[indexPath.row] {
                PersonController.shared.delete(person: person)
            }
        }
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add a person!", message: nil, preferredStyle: .alert)
        alertController.addTextField { (newlyAddedTextField) in
            newlyAddedTextField.placeholder = "Enter persons name..."
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let personName = alertController.textFields?[0].text else { return }
            PersonController.shared.add(name: personName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        
    }

}


// MARK: - FetchResultsControllerDelegate Methods
extension GroupTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        case .insert:
            guard let indexPath = newIndexPath else { return }
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
