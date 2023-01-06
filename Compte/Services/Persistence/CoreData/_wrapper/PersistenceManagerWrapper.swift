//
//  PersistenceManagerWrapper.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation
import Combine

// MARK: - PersistenceManagerError
enum PersistenceManagerError: LocalizedError {
    case entityCollectionIsEmpty
    case unkown
}
// MARK: - PersistenceManagerProtocol
protocol PersistenceManagerProtocol: ObservableObject {
    var compteModelCollection: Set<CompteObject> { get }

    func fetch(mapper: some ModelMapper)
    func add(mapper: any ModelMapper, requireSave: Bool)
    func update(mapper: any ModelMapper, requireSave: Bool)
    func delete(mapper: some ModelMapper, requireSave: Bool)
    func clear(requireSave: Bool)
    func save()
}
