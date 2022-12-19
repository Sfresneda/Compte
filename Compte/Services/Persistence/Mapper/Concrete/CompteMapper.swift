//
//  CompteMapper.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation
import CoreData

struct CompteMapper {
    static var uniqueIdentifier: String { String(describing: self) }
    
    let object: CompteObject?
    var entity: NSManagedObject.Type {
        CompteEntity.self
    }
    
    init(_ object: CompteObject? = nil) { self.object = object }
}
extension CompteMapper: ModelMapper {
    func filterItemSelected(in collection: [NSManagedObject]) -> NSManagedObject? {
        guard let entitiesCollection = collection as? [CompteEntity] else {
            return nil
        }
        return entitiesCollection
            .first { $0.id == object?.id }
    }
    func fetch(_ collection: [NSFetchRequestResult]) -> Set<CompteObject> {
        CompteMapper.buildCollection(collection)
    }
    func insert(_ context: NSManagedObjectContext) {
        guard let object else { return }
        let newObject = CompteEntity(context: context)
        newObject.id = object.id
        newObject.date = object.date
        newObject.name = object.name
        newObject.taps = []
    }
    func update(_ entity: NSManagedObject, context: NSManagedObjectContext) {
        guard let compteEntity = entity as? CompteEntity,
        let object else {
            return
        }
        compteEntity.date = object.date
        compteEntity.name = object.name
    }
    func delete(_ entity: NSManagedObject, context: NSManagedObjectContext) {
        context.delete(entity)
    }
    static func buildCollection(_ collection: [NSFetchRequestResult]) -> [CompteObject] {
        collection
            .compactMap { $0 as? CompteEntity }
            .map {
                CompteObject(id: $0.id,
                             date: $0.date,
                             name: $0.name)
            }
    }
    static func buildCollection(_ collection: [NSFetchRequestResult]) -> Set<CompteObject> {
        let objectsCollection: [CompteObject] = CompteMapper.buildCollection(collection)
        return Set(objectsCollection)
    }
}
