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

    init(id: UUID?,
         date: TimeInterval,
         tapNumber: Int) {
        self.id = id ?? UUID()
        self.date = date
        self.tapNumber = tapNumber
    }
}
extension TapObject: Hashable {}
