//
//  TapObject.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation

struct TapObject {
    let id: UUID
    let date: TimeInterval
    let tapNumber: Int

    init(id: UUID? = nil,
         date: TimeInterval,
         tapNumber: Int) {
        self.id = id ?? UUID()
        self.date = date
        self.tapNumber = tapNumber
    }
}
extension TapObject: Hashable {}
extension TapObject {
    var dateFormatted: Date {
        Date(timeIntervalSince1970: date)
    }
}
extension TapObject {
    static func defaultImplementation() -> Self {
        TapObject(date: Date().timeIntervalSince1970, tapNumber: .zero)
    }
}
