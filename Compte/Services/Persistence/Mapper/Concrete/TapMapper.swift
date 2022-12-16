//
//  TapMapper.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
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
    func fetch(_ collection: [NSFetchRequestResult]) -> Set<TapObject> {
        TapMapper.buildCollection(collection)
    }
    func insert(_ context: NSManagedObjectContext) {
        guard let object else { return }
        let newObject = TapEntity(context: context)
        newObject.id = object.id
        newObject.date = object.date
        newObject.number = Int16(object.tapNumber)
    }
    func update(_ context: NSManagedObjectContext) {
        // do stuff
    }
    func delete(_ context: NSManagedObjectContext) {
        // do stuff
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
