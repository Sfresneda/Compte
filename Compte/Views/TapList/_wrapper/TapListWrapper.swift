//
//  TapListWrapper.swift
//  Compte
//
//  Created by likeadeveloper on 20/12/22.
//

import Foundation

// MARK: - TapListVModelProtocol
protocol TapListVModelProtocol: ObservableObject {
    var name: String { get }
    var items: [TapObject] { get set }
    var firstItemIdentifier: UUID? { get }
    var numberOfTaps: Int { get set }

    func add()
    func delete(_ id: UUID)
    func cleanData()
}
