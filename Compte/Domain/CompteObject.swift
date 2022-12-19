//
//  CompteObject.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation

struct CompteObject {
    let id: UUID
    let date: Double
    let name: String
    let taps: [TapObject]?

    init(id: UUID?,
         date: Double,
         name: String?,
         taps: [TapObject]? = nil) {
        self.id = id ?? UUID()
        self.date = date
        self.name = name ?? "Compte-\(self.id.uuidString.prefix(5))"
        self.taps = taps
    }
}
extension CompteObject: Hashable {}
extension CompteObject {
    var dateFormatted: Date {
        Date(timeIntervalSince1970: date)
    }
}
