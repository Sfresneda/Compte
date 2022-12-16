//
//  ItemsListVModel.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import Combine

@MainActor
final class ItemsListVModel: ObservableObject {
    var items: [CompteObject]  {
        dataManager.compteModelCollection.sorted { $0.date < $1.date }
    }
    private var cancellable: AnyCancellable?
    @Published private var dataManager: PersistenceManager

    init(dataManager: PersistenceManager = PersistenceManager.shared) {
        self.dataManager = dataManager
        cancellable = dataManager
            .objectWillChange
            .sink(receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            })
        defer { dataManager.fetch(mapper: CompteMapper()) }
    }

    func add(with name: String?) {
        let newObject = CompteObject(id: nil,
                                     date: Date().timeIntervalSince1970,
                                     name: name)
        dataManager
            .add(mapper: CompteMapper(newObject),
                 requireSave: true)
    }
    func updateName(for id: UUID, name: String) {
        guard let object = items.first(where: { $0.id == id }) else { return }
        let updatedObject = CompteObject(id: object.id,
                                         date: object.date,
                                         name: name)

        dataManager
            .update(mapper: CompteMapper(updatedObject))
    }
    func delete(with id: UUID) {
        guard let object = items.first(where: { $0.id == id }) else { return }
        dataManager
            .delete(mapper: CompteMapper(object))
    }
    func clear() {
        dataManager
            .clear(requireSave: true)
    }
}
