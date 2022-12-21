//
//  TapObject.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation

// MARK: - TapObject
struct TapObject {
    let id: UUID
    let date: TimeInterval
    let tapNumber: Int
    let parentId: UUID?

    init(id: UUID? = nil,
         date: TimeInterval,
         tapNumber: Int,
         parentId: UUID? = nil) {
        self.id = id ?? UUID()
        self.date = date
        self.tapNumber = tapNumber
        self.parentId = parentId
    }
}
// MARK: - HashableMappedModel
extension TapObject: HashableMappedModel {
    var relationIdentifier: UUID? {
        parentId
    }
}
// MARK: - Public Helpers
extension TapObject {
    var dateFormatted: Date {
        Date(timeIntervalSince1970: date)
    }
}
// MARK: - Statics
extension TapObject {
    static func defaultImplementation() -> Self {
        TapObject(date: Date().timeIntervalSince1970, tapNumber: .zero)
    }
}
