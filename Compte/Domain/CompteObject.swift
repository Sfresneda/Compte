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
    var name: String
    let taps: [TapObject]?
    var lastModified: Double

    init(id: UUID? = nil,
         date: Double,
         name: String?,
         taps: [TapObject]? = nil,
         lastModified: Double) {
        self.id = id ?? UUID()
        self.date = date
        self.name = name ?? "Compte-\(self.id.uuidString.prefix(5))"
        self.taps = taps
        self.lastModified = lastModified
    }
}
extension CompteObject: Hashable {}
extension CompteObject {
    var dateFormatted: Date {
        Date(timeIntervalSince1970: date)
    }
    var lastModifiedDateFormatted: Date {
        Date(timeIntervalSince1970: lastModified)
    }

    static func defaultImplementation() -> Self {
        CompteObject(id: UUID(),
                     date: Date().timeIntervalSince1970,
                     name: "",
                     lastModified: Date().timeIntervalSince1970)
    }
}
