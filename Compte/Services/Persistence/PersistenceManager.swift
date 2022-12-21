//
//  PersistenceManager.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import CoreData
import Combine

// MARK: - PersistenceManager
final class PersistenceManager: NSObject, ObservableObject {
    static var shared: PersistenceManager = PersistenceManager()
    
    @Published var compteModelCollection: Set<CompteObject> = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    fileprivate var managedObjectContext: NSManagedObjectContext
    private let entityRequestController: NSFetchedResultsController<CompteEntity>
    private var dataStore: DataStore
    
    init(dataStore: DataStore = DataStore()) {
        self.dataStore = dataStore
        managedObjectContext = self.dataStore.context
        
        let compteRequest = CompteEntity.fetchRequest()
        compteRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        entityRequestController = NSFetchedResultsController(fetchRequest: compteRequest,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
        
        super.init()
        
        entityRequestController.delegate = self
        
        try? entityRequestController.performFetch()
    }
}
// MARK: - Public CRUD
extension PersistenceManager: PersistenceManagerProtocol {
    func fetch(mapper: some ModelMapper) {
        guard let collection = try? entitiesCollection(),
              let mappedObjects = mapper.fetch(collection) as? Set<CompteObject> else { return }
        
        compteModelCollection = mappedObjects
    }
    func add(mapper: any ModelMapper, requireSave: Bool = false) {
        defer { if requireSave { save() } }
        mapper
            .insert(dataStore.context,
                    relationEntityClosure: {
                entityRequestController
                    .fetchedObjects?
                    .first(where: { mapper.object?.relationIdentifier == $0.id })
            }())
    }
    func update(mapper: any ModelMapper, requireSave: Bool = false) {
        defer { if requireSave { save() } }
        guard let collection = try? entitiesCollection(),
              let entity = mapper.filterItemSelected(in: collection) else {
            return
        }
        mapper.update(entity,
                      context: dataStore.context)
    }
    func delete(mapper: some ModelMapper,
                requireSave: Bool = false) {
        defer { if requireSave { save() } }
        guard let entities = entityRequestController.fetchedObjects,
              let entity = mapper.filterItemSelected(in: entities) else { return }
        managedObjectContext.delete(entity)
    }
    func clear(requireSave: Bool) {
        defer { if requireSave { save() } }
        entityRequestController
            .fetchedObjects?
            .forEach { managedObjectContext.delete($0) }
    }
    func save() {
        dataStore.save()
    }
}
// MARK: - Helpers
private extension PersistenceManager {
    func entitiesCollection() throws -> [NSManagedObject]? {
        guard let objects = try? managedObjectContext
            .fetch(entityRequestController.fetchRequest) else {
            throw PersistenceManagerError.entityCollectionIsEmpty
        }
        return objects
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension PersistenceManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedCollection = controller.fetchedObjects,
              let items = fetchedCollection as? [CompteEntity] else {
            return
        }
        compteModelCollection = CompteMapper.buildCollection(items)
    }
}
