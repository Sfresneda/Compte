//
//  TapListVModel.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import Foundation
import Combine

// MARK: - TapListVModel
@MainActor
final class TapListVModel {
    // MARK: Vars
    @Published var numberOfTaps: Int = .zero
    @Published var items: [TapObject] = [] {
        didSet {
            numberOfTaps = items.count
        }
    }
    @Published var name: String

    private enum Constant {
        static let saveQueueDelay: useconds_t = 1000000 // 1 second
    }
    private var modelObject: CompteObject
    private var cancellable: AnyCancellable?
    private var dataManager: PersistenceManager
    private var saveOperationQueue: OperationQueue = {
        let oq = OperationQueue()
        oq.maxConcurrentOperationCount = 1
        oq.qualityOfService = .userInitiated
        oq.name = "com.mainvmodel.saveoperationqueue"
        return oq
    }()

    // MARK: Lifecycle
    init(modelObject: CompteObject,
         dataManager: PersistenceManager = PersistenceManager.shared) {
        self.modelObject = modelObject
        self.name = modelObject.name
        self.dataManager = dataManager
        self.items = modelObject.taps.sorted(by: { $0.date > $1.date })
        self.numberOfTaps = self.items.count
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
    }
    func cleanData() {
        defer { dataManager.save() }
        dataManager.update(mapper: CompteMapper(modelObject.copyWithDefaultState()))
        items.removeAll()
    }
}
// MARK: - Helpers
private extension TapListVModel {
    func store(_ object: TapObject) {
        dataManager.add(mapper: TapMapper(object))
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
    func fetchData() {
        dataManager.fetch(mapper: CompteMapper(modelObject))
    }
}
