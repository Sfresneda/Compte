//
//  TapMapper.swift
//  Compte
//
//  Created by likeadeveloper on 20/12/22.
//

import Foundation
import CoreData

struct TapMapper {
    static var uniqueIdentifier: String { String(describing: self) }

    let object: TapObject?
    var entity: NSManagedObject.Type {
        TapEntity.self
    }

    init(_ object: TapObject? = nil) { self.object = object }

}
extension TapMapper: ModelMapper {
    func filterItemSelected(in collection: [NSManagedObject]) -> NSManagedObject? {
        guard let entitiesCollection = collection as? [TapEntity] else {
            return nil
        }
        return entitiesCollection.first { $0.id == object?.id }
    }
    func fetch(_ collection: [NSFetchRequestResult]) -> Set<TapObject> {
        TapMapper.buildCollection(collection)
    }
    func insert(_ context: NSManagedObjectContext,
                relationEntityClosure: @autoclosure (() -> NSManagedObject?)) {
        guard let object else { return }
        let tapEntity = TapEntity(context: context)
        tapEntity.id = object.id
        tapEntity.date = object.date
        tapEntity.number = Int16(object.tapNumber)
        tapEntity.compte = relationEntityClosure() as? CompteEntity
    }
    func update(_ entity: NSManagedObject,
                context: NSManagedObjectContext) {
        guard let tapEntity = entity as? TapEntity,
              let object else { return }

        tapEntity.date = object.date
        tapEntity.number = Int16(object.tapNumber)
    }
    func delete(_ entity: NSManagedObject, context: NSManagedObjectContext) {
        context.delete(entity)
    }
    static func buildCollection(_ collection: [NSFetchRequestResult]) -> [TapObject] {
        collection
            .compactMap { $0 as? TapEntity }
            .map {
                TapObject(id: $0.id,
                          date: $0.date,
                          tapNumber: Int($0.number))
            }
    }
    static func buildCollection(_ collection: [NSFetchRequestResult]) -> Set<TapObject> {
        let objectsCollection: [TapObject] = TapMapper.buildCollection(collection)
        return Set(objectsCollection)
    }
}
