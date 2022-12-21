//
//  BoardListVModel.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import Combine

// MARK: - BoardListVModel
@MainActor
final class BoardListVModel: ObservableObject {
    // MARK: Vars
    @Published var items: [CompteObject] = []
    var isItemsEmpty: Bool { items.isEmpty }
    @Published var isEditNamePresented: Bool = false
    @Published var selectedItem: CompteObject = .defaultImplementation() {
        didSet {
            selectedItemName = selectedItem.name
        }
    }
    @Published var selectedItemName: String = ""
    @Published var navigationBarItems: [NavbarButton] = Constants.defaultNavbarItems

    var firstItemIdentifier: UUID? {
        items.first?.id
    }
    private var cancellable: AnyCancellable?
    private var dataManager: PersistenceManager
    private enum Constants {
        static let defaultNavbarItems: [NavbarButton] = []
    }
    
    // MARK: Lifecycle
    init(dataManager: PersistenceManager = PersistenceManager.shared) {
        self.dataManager = dataManager
        cancellable = dataManager
            .objectWillChange
            .sink(receiveValue: { [weak self] _ in
                self?.items = dataManager.compteModelCollection.sorted { $0.lastModified > $1.lastModified }
                self?.objectWillChange.send()
            })
        defer { fetchData() }
    }
}
// MARK: - Contract
extension BoardListVModel: BoardListVModelProtocol {
    func handleNavbarButton(_ button: NavbarButton) {
        switch button {
        case .new:
            add()
        default:
            break
        }
    }
    func add(with name: String? = nil) {
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
private extension BoardListVModel {
    func fetchData() {
        dataManager.fetch(mapper: CompteMapper())
    }
}
