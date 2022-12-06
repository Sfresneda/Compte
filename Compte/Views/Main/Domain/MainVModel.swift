//
//  MainVModel.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import Foundation
import Combine

protocol MainViewModel: ObservableObject {
    var screenName: String { get }
}

// MARK: - MainVModel
class MainVModel {
    // MARK: Vars
    private enum Constants {
        static let defaultName = "Compte"
    }
    private var name: String?
    @Published var numberOfTaps: Int = .zero
    @Published var tapsCollection: [TapModel] = []
    
    // MARK: Lifecycle
}
// MARK: - Contract
extension MainVModel: MainViewModel {
    var screenName: String {
        name ?? Constants.defaultName
    }
    func increaseTaps() {
        numberOfTaps += 1
        insertNewTapToCollection()
    }
}
// MARK: - Helpers
private extension MainVModel {
    func insertNewTapToCollection() {
        let newTap = TapModel(date: Date().timeIntervalSince1970,
                              tapNumber: numberOfTaps)
        tapsCollection.insert(newTap, at: 0)
    }
}
// MARK: - Storage
private extension MainVModel {
    
}
