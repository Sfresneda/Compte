//
//  ItemsListVModel.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import Combine

final class ItemsListVModel: ObservableObject {
    @Published var items: [CompteEntity] = []
    private var cancellable: AnyCancellable?
    private var dataManager: CompteManager

    init(dataManager: CompteManager!) {
        self.dataManager = dataManager

        cancellable = dataManager.models.sink(receiveValue: { itemBlock in
            self.items = itemBlock
        })
    }

    func add(with name: String?) {
        let newModel = CompteEntity(context: dataManager.context)
        let modelId = UUID()
        newModel.id = modelId
        newModel.date = Date().timeIntervalSince1970
        newModel.name = name ?? "Compte-\(modelId.uuidString.prefix(5))"
        dataManager
            .add(newModel, requireSave: true)
    }
    func clear() {
        dataManager
            .clearAll(requireSave: true)
    }
}
