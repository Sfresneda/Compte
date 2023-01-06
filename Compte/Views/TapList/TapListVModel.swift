//
//  TapListVModel.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import Foundation
import Combine

private enum Constant {
    static let saveQueueDelay: useconds_t = 1000000 // 1 second
    static let queueName: String = "com.taplistvmodel.saveoperationqueue"
}

// MARK: - TapListVModel
final class TapListVModel<DataManager: PersistenceManagerProtocol>: ObservableObject {
    // MARK: Vars
    @Published var numberOfTaps: Int = .zero
    @Published var items: [TapObject] = [] {
        didSet {
            numberOfTaps = items.count
        }
    }
    var isItemsEmpty: Bool {
        items.isEmpty
    }
    var firstItemIdentifier: UUID? { items.first?.id }
    @Published var name: String

    private var modelObject: CompteObject
    private var cancellable: AnyCancellable?
    private var dataManager: DataManager
    private var saveOperationQueue: OperationQueue = {
        let oq = OperationQueue()
        oq.maxConcurrentOperationCount = 1
        oq.qualityOfService = .userInitiated
        oq.name = Constant.queueName
        return oq
    }()

    // MARK: Lifecycle
    init(modelObject: CompteObject,
         dataManager: DataManager = PersistenceManager.shared) {
        self.modelObject = modelObject
        self.name = modelObject.name
        self.items = modelObject
            .taps
            .sorted(by: { $0.date > $1.date })
        self.numberOfTaps = modelObject.taps.count
        self.dataManager = dataManager
        cancellable = self.dataManager
            .objectWillChange
            .sink { _ in } receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            }
    }
}
// MARK: - Contract
extension TapListVModel: TapListVModelProtocol {
    func add() {
        let newObject = TapObject(date: Date().timeIntervalSince1970,
                                  tapNumber: items.count + 1,
                                  parentId: modelObject.id)
        items.insert(newObject, at: .zero)

        store(newObject)
    }
    func delete(_ id: UUID) {
        guard let object = items.first(where: { $0.id == id }) else { return }
        dataManager.delete(mapper: TapMapper(object), requireSave: true)
        items.removeAll(where: { $0.id == id })
    }
    func cleanData() {
        guard !items.isEmpty else { return }
        defer { dataManager.save() }
        dataManager.update(mapper: CompteMapper(modelObject.copyWithDefaultState()),
                           requireSave: false)
        items.removeAll()
    }
}
// MARK: - Helpers
private extension TapListVModel {
    func store(_ object: TapObject) {
        dataManager.add(mapper: TapMapper(object),
                        requireSave: false)
        enqueueSaveOperation()
    }
    func enqueueSaveOperation() {
        saveOperationQueue.cancelAllOperations()

        let operation = BlockOperation()
        operation.addExecutionBlock { [weak self] in
            usleep(Constant.saveQueueDelay)
            guard !operation.isCancelled else { return }
            self?.dataManager.save()
        }

        saveOperationQueue.addOperation(operation)
    }
}
