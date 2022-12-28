//
//  DataStore.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation
import CoreData

// MARK: - DataStore
struct DataStore {
    // MARK: Vars
    var container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }

    // MARK: Lifecycle
    init(dataModelName: String = "CompteModel") {
        container = NSPersistentContainer(name: dataModelName)
        context.automaticallyMergesChangesFromParent = true

        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
// MARK: - Public
extension DataStore: DataStoreProtocol {
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            assertionFailure("something went wrong saving user data: \(error)")
        }
    }
}
