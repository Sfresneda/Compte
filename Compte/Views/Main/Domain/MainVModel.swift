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
    private enum Constants {
        static let defaultName = "Compte"
    }
    @Published var name: String = Constants.defaultName
    @Published var numberOfTaps: Int = .zero
    @Published var tapsCollection: [TapModel] = []
    
    // MARK: Lifecycle
}
// MARK: - Contract
extension MainVModel: MainViewModel {
    func increaseTaps() {
        numberOfTaps += 1
        insertNewTapToCollection()
    }
    func cleanData() {
        numberOfTaps = .zero
        tapsCollection.removeAll()
    }
}
// MARK: - Helpers
private extension MainVModel {
    func insertNewTapToCollection() {
        let newTap = TapModel(date: Date().timeIntervalSince1970,
                              tapNumber: numberOfTaps)
        tapsCollection.insert(newTap,
                              at: .zero)
    }
}
// MARK: - Storage
private extension MainVModel {
    
}
