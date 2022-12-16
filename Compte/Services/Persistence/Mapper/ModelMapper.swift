//
//  ModelMapper.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation
import CoreData

protocol ModelMapper {
    associatedtype ModelObject: Hashable

    static var uniqueIdentifier: String { get }
    var object: ModelObject? { get }
    var entity: NSManagedObject.Type { get }

    func fetch(_ collection: [NSFetchRequestResult]) -> Set<ModelObject>
    func insert(_ context: NSManagedObjectContext)
    func update(_ context: NSManagedObjectContext)
    func delete(_ context: NSManagedObjectContext)

    static func buildCollection(_ collection: [NSFetchRequestResult]) -> [ModelObject]
    static func buildCollection(_ collection: [NSFetchRequestResult]) -> Set<ModelObject>
}
