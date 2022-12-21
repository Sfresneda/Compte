//
//  CompteObject.swift
//  Compte
//
//  Created by likeadeveloper on 15/12/22.
//

import Foundation

// MARK: - CompteObject
struct CompteObject {
    let id: UUID
    let date: Double
    var name: String
    let taps: [TapObject]
    var lastModified: Double

    init(id: UUID? = nil,
         date: Double,
         name: String?,
         taps: [TapObject] = [],
         lastModified: Double = Date().timeIntervalSince1970) {
        self.id = id ?? UUID()
        self.date = date
        self.name = name ?? "Compte-\(self.id.uuidString.prefix(5))"
        self.taps = taps
        self.lastModified = lastModified
    }
}
// MARK: - HashableMappedModel
extension CompteObject: HashableMappedModel {
    var relationIdentifier: UUID? {
        nil
    }
}
// MARK: - Public Helpers
extension CompteObject {
    var dateFormatted: Date {
        Date(timeIntervalSince1970: date)
    }
    var lastModifiedDateFormatted: Date {
        Date(timeIntervalSince1970: lastModified)
    }
    func copyWithDefaultState() -> Self {
        return CompteObject(id:self.id, date: self.date, name: self.name)
    }
}
// MARK: - Statics
extension CompteObject {
    static func defaultImplementation() -> Self {
        CompteObject(date: Date().timeIntervalSince1970, name: "", lastModified: Date().timeIntervalSince1970)
    }
}
