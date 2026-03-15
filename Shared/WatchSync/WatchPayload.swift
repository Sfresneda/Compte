//
//  WatchPayload.swift
//  Compte
//
//  Created by sergio fresneda on 3/15/26.
//

import Foundation

struct WatchPayload: Codable, Hashable {
    let boards: [BoardSnapshot]
    let generatedAt: TimeInterval
}
