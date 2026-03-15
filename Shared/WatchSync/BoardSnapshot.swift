//
//  BoardSnapshot.swift
//  Compte
//
//  Created by sergio fresneda on 3/15/26.
//

import Foundation

struct BoardSnapshot: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let tapCount: Int
    let lastModified: TimeInterval
}

