//
//  ItemsListVModel.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import Combine

// MARK: - ItemsListVModelProtocol
protocol ItemsListVModelProtocol: ObservableObject {
    var items: [CompteObject] { get set }
    var isEditNamePresented: Bool { get set }

    var selectedItem: CompteObject { get set }
    var selectedItemName: String { get }

    func add(with name: String?)
    func updateName(_ name: String)
    func delete(_ id: UUID)
}

@MainActor
final class ItemsListVModel: ObservableObject {
    // MARK: Vars
    @Published var items: [CompteObject] = []
    @Published var isEditNamePresented: Bool = false
    @Published var selectedItem: CompteObject = .defaultImplementation() {
        didSet {
            selectedItemName = selectedItem.name
        }
    }
    @Published var selectedItemName: String = ""

    private var cancellable: AnyCancellable?
    @Published private var dataManager: PersistenceManager
    
    // MARK: Lifecycle
    init(dataManager: PersistenceManager = PersistenceManager.shared) {
        self.dataManager = dataManager
        cancellable = dataManager
            .objectWillChange
            .sink(receiveValue: { [weak self] _ in
                self?.items = dataManager.compteModelCollection.sorted { $0.lastModified < $1.lastModified }
                self?.objectWillChange.send()
            })
        defer { fetchData() }
    }
}
// MARK: - Contract
extension ItemsListVModel: ItemsListVModelProtocol {
    func add(with name: String?) {
        let newObject = CompteObject(date: Date().timeIntervalSince1970,
                                     name: name,
                                     lastModified: Date().timeIntervalSince1970)
        dataManager
            .add(mapper: CompteMapper(newObject),
                 requireSave: true)
    }
    func updateName(_ name: String) {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              name != selectedItem.name else { return }
        selectedItem.name = name
        selectedItem.lastModified = Date().timeIntervalSince1970

        dataManager
            .update(mapper: CompteMapper(selectedItem),
                    requireSave: true)
    }
    func delete(_ id: UUID) {
        guard let object = items.first(where: { $0.id == id }) else { return }
        dataManager
            .delete(mapper: CompteMapper(object),
                    requireSave: true)
    }
}
// MARK: - Helpers
private extension ItemsListVModel {
    func fetchData() {
        dataManager.fetch(mapper: CompteMapper())
    }
}
