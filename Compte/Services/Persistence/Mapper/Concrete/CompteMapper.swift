//
//  CompteMapper.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation
import CoreData

// MARK: - TapMapper
struct CompteMapper: ModelMapper {
    static var uniqueIdentifier: String { String(describing: self) }
    let object: CompteObject?

    init(_ object: CompteObject? = nil) { self.object = object }
}
// MARK: - Public CRUD
extension CompteMapper {
    func fetch(_ collection: [NSFetchRequestResult]) -> Set<CompteObject> {
        CompteMapper.buildCollection(collection)
    }
    func insert(_ context: NSManagedObjectContext,
                relationEntityClosure: @autoclosure (() -> NSManagedObject?)) {
        guard let object else { return }
        let compteEntity = CompteEntity(context: context)
        compteEntity.id = object.id
        compteEntity.date = object.date
        compteEntity.name = object.name
        compteEntity.lastModified = Date().timeIntervalSince1970
        compteEntity.taps = []
    }
    func update(_ entity: NSManagedObject,
                context: NSManagedObjectContext) {
        guard let compteEntity = entity as? CompteEntity,
              let object else { return }

        compteEntity.date = object.date
        compteEntity.name = object.name
        compteEntity.lastModified = Date().timeIntervalSince1970

        if object.taps.isEmpty {
            compteEntity.taps = []
        }
    }
    func delete(_ entity: NSManagedObject, context: NSManagedObjectContext) {
        context.delete(entity)
    }
}
// MARK: - Public Helpers
extension CompteMapper {
    func filterItemSelected(in collection: [NSManagedObject]) -> NSManagedObject? {
        guard let entitiesCollection = collection as? [CompteEntity] else {
            return nil
        }
        return entitiesCollection.first { $0.id == object?.id }
    }
}
// MARK: - Statics
extension CompteMapper {
    static func buildCollection(_ collection: [NSFetchRequestResult]) -> [CompteObject] {
        collection
            .compactMap { $0 as? CompteEntity }
            .map {
                let taps = $0.taps?
                    .compactMap { $0 as? TapEntity }
                    .map { tap in
                        TapObject(id: tap.id, date: tap.date, tapNumber: Int(tap.number))
                    }

                return CompteObject(id: $0.id,
                                    date: $0.date,
                                    name: $0.name,
                                    taps: taps ?? [],
                                    lastModified: $0.lastModified)
            }
    }
    static func buildCollection(_ collection: [NSFetchRequestResult]) -> Set<CompteObject> {
        let objectsCollection: [CompteObject] = CompteMapper.buildCollection(collection)
        return Set(objectsCollection)
    }
}
