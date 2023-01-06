//
//  BoardListVModel.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import Combine

private enum Constants {
    static let defaultNavbarItems: [NavbarButton] = []
}

// MARK: - BoardListVModel
final class BoardListVModel<DataManager: PersistenceManagerProtocol>: ObservableObject {
    // MARK: Vars
    @Published var items: [CompteObject] = []
    var isItemsEmpty: Bool { items.isEmpty }
    @Published var isRenameViewPresented: Bool = false
    @Published var navigationBarItems: [NavbarButton] = Constants.defaultNavbarItems
    var firstItemIdentifier: UUID? { items.first?.id }
    var objectToRename: CompteObject?
    var isAnObjectToRename: Bool { nil != objectToRename }

    private var cancellable: AnyCancellable?
    private var dataManager: DataManager

    // MARK: Lifecycle
    init(dataManager: DataManager = PersistenceManager.shared) {
        self.dataManager = dataManager
        cancellable = dataManager
            .objectWillChange
            .sink(receiveValue: { [weak self] _ in
                let newItems = dataManager.compteModelCollection.sorted { $0.lastModified > $1.lastModified }
                self?.items = newItems
                self?.objectWillChange.send()
            })
        defer { fetchData() }
    }
}
// MARK: - Contract
extension BoardListVModel: BoardListVModelProtocol {
    func renameViewInvocationAction(_ action: RenameViewPresentingAction) {
        isRenameViewPresented.toggle()

        switch action {
        case .new:
            break
        case .edit(let item):
            objectToRename = item
        case .done:
            objectToRename = nil
            isRenameViewPresented = false
        }
    }
    func renameViewSubmitAction(_ action: RenameViewSubmitAction) {
        switch action {
        case .add(let newName):
            add(with: newName)
        case .update(let newName):
            updateName(newName)
        }
        renameViewInvocationAction(.done)
    }
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
        guard var objectToRename,
              !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              name != objectToRename.name else {
            return
        }
        objectToRename.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        objectToRename.lastModified = Date().timeIntervalSince1970

        dataManager
            .update(mapper: CompteMapper(objectToRename),
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
