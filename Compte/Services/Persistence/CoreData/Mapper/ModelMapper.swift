//
//  ModelMapper.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation
import CoreData

// MARK: - HashableMappedModel
protocol HashableMappedModel: Hashable {
    var relationIdentifier: UUID? { get }
}

// MARK: - ModelMapper
protocol ModelMapper {
    associatedtype ModelObject: HashableMappedModel

    static var uniqueIdentifier: String { get }
    var object: ModelObject? { get }

    func fetch(_ collection: [NSFetchRequestResult]) -> Set<ModelObject>
    func insert(_ context: NSManagedObjectContext,
                relationEntityClosure: @autoclosure (() -> NSManagedObject?))
    func update(_ entity: NSManagedObject,
                context: NSManagedObjectContext)
    func delete(_ entity: NSManagedObject, context: NSManagedObjectContext)

    func filterItemSelected(in collection: [NSManagedObject]) -> NSManagedObject?

    static func buildCollection(_ collection: [NSFetchRequestResult]) -> [ModelObject]
    static func buildCollection(_ collection: [NSFetchRequestResult]) -> Set<ModelObject>
}
