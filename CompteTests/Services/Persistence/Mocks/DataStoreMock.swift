//
//  DataStoreMock.swift
//  CompteTests
//
//  Created by likeadeveloper on 27/12/22.
//

import Foundation
import CoreData
@testable import Compte

struct DataStoreMock {
    var container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "CompteModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        context.automaticallyMergesChangesFromParent = true

        container.persistentStoreDescriptions = [description]
        let compteRequest = CompteEntity.fetchRequest()
        compteRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        container.loadPersistentStores { description, error in
            precondition(description.type == NSInMemoryStoreType)

            if let error = error {
                fatalError("in-app memory persistence error: \(error)")
            }
        }
    }
}
extension DataStoreMock: DataStoreProtocol {
    var context: NSManagedObjectContext {
        container.viewContext
    }

    func save() {
        // silent is golden
    }
}
