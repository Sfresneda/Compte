//
//  MainVModel.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import Foundation
import Combine

protocol MainViewModel: ObservableObject {
    func increaseTaps()
    func cleanData()
}

// MARK: - MainVModel
class MainVModel {
    // MARK: Vars
    private enum Constants { static let defaultName = "Compte" }
    @Published var name: String = Constants.defaultName
    @Published var numberOfTaps: Int = .zero
    @Published var items: [TapEntity] = []
    private var cancellable: AnyCancellable?

    // MARK: Lifecycle
}
// MARK: - Contract
extension MainVModel: MainViewModel {
    func increaseTaps() {
        insertNewTapToCollection()
    }
    func cleanData() {
        items.removeAll()
    }
}
// MARK: - Helpers
private extension MainVModel {
    func insertNewTapToCollection() {
    }
}
// MARK: - Storage
private extension MainVModel {
    
}
