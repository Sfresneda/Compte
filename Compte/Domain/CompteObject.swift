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

    init(id: UUID?,
         date: Double,
         name: String?) {
        self.id = id ?? UUID()
        self.date = date
        self.name = name ?? "Compte-\(self.id.uuidString.prefix(5))"
    }
}
extension CompteObject: Hashable {}
