//
//  DataStore.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation
import CoreData

struct DataStore {
    var container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        container = NSPersistentContainer(name:"CompteModel")
        context.automaticallyMergesChangesFromParent = true

        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            fatalError("something went wrong saving user data: \(error)")
        }
    }
}
