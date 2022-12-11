//
//  PersistenceManager.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import CoreData
import Combine

class PersistenceManager<EntityModel: NSManagedObject>: NSObject, ObservableObject {
    var models = CurrentValueSubject<[EntityModel], Never>([])
    let modelFetcherController: NSFetchedResultsController<EntityModel>
    let context: NSManagedObjectContext
    private var isReady: Bool = false
    
    init(container: NSPersistentContainer) {
        let request = EntityModel.fetchRequest()
        request.sortDescriptors = []

        modelFetcherController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil) as! NSFetchedResultsController<EntityModel>
        self.context = container.viewContext
        super.init()

        container.loadPersistentStores(completionHandler: { [weak self] _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self?.isReady.toggle()
        })

        do {
            try modelFetcherController.performFetch()
            models.value = modelFetcherController.fetchedObjects ?? []
        } catch {
            NSLog("Could not fetch models data")
        }
    }

    func add(_ model: EntityModel, requireSave: Bool = false) {
        if requireSave { save() }
    }
    func update(_ id: UUID, requireSave: Bool = false) {
        if requireSave { save() }
    }
    func delete(_ id: UUID, requireSave: Bool = false) {
        if requireSave { save() }
    }
    func clearAll(requireSave: Bool = false) {
        defer {
            if requireSave { save() }
        }

        models.value.forEach { context.delete($0) }
    }
    
    final func executeRequestWithoutResult(_ request: NSPersistentStoreRequest) {
        do {
            try context.execute(request)
            save()
        } catch {
            fatalError("something went wrong executing the request: \(error)")
        }
    }
    final func save() {
        guard isReady, context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            fatalError("something went wrong saving user data: \(error)")
        }
    }
}
