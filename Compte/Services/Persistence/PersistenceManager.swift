//
//  PersistenceManager.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import CoreData
import Combine

final class PersistenceManager: NSObject, ObservableObject {
    static var shared: PersistenceManager = PersistenceManager()

    @Published var compteModelCollection: Set<CompteObject> = []
    @Published var tapsModelCollection: Set<TapObject> = []

    fileprivate var managedObjectContext: NSManagedObjectContext
    private let compteRequestController: NSFetchedResultsController<CompteEntity>
    private let tapsRequestController: NSFetchedResultsController<TapEntity>
    private var dataStore: DataStore

    private override init() {
        dataStore = DataStore()
        managedObjectContext = dataStore.context

        let compteRequest = CompteEntity.fetchRequest()
        compteRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        compteRequestController = NSFetchedResultsController(fetchRequest: compteRequest,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)

        let tapRequest = TapEntity.fetchRequest()
        tapRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        tapsRequestController = NSFetchedResultsController(fetchRequest: tapRequest,
                                                           managedObjectContext: managedObjectContext,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)

        super.init()

        compteRequestController.delegate = self
        tapsRequestController.delegate = self

        try? compteRequestController.performFetch()
        try? tapsRequestController.performFetch()
    }
}

extension PersistenceManager: PersistenceManagerProtocol {
    func fetch(mapper: some ModelMapper) {
        guard let objects = try? managedObjectContext.fetch(compteRequestController.fetchRequest) else { return }
        let mappedObjects = mapper.fetch(objects)
        if let compteCollection = mappedObjects as? Set<CompteObject> {
            compteModelCollection = compteCollection
        } else if let tapCollection = mappedObjects as? Set<TapObject> {
            tapsModelCollection = tapCollection
        }
    }
    func add(mapper: any ModelMapper, requireSave: Bool = false) {
        defer { if requireSave { save() } }
        mapper.insert(dataStore.context)
    }
    func update(mapper: any ModelMapper, requireSave: Bool = false) {
        defer { if requireSave { save() } }
        mapper.update(dataStore.context)
    }
    func delete(mapper: any ModelMapper, requireSave: Bool = false) {
        defer { if requireSave { save() } }
        mapper.delete(dataStore.context)
    }
    func clear(requireSave: Bool) {
        defer { if requireSave { save() } }
        //do stuff
        debugPrint("do stuff here")
    }
    func save() {
        dataStore.save()
    }
}

extension PersistenceManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedCollection = controller.fetchedObjects else { return }

        if let items = fetchedCollection as? [CompteEntity] {
            compteModelCollection = CompteMapper.buildCollection(items)
        } else if let items = fetchedCollection as? [TapEntity] {
            tapsModelCollection = TapMapper.buildCollection(items)
        }
    }
}
