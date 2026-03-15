//
//  WatchCommand.swift
//  Compte
//
//  Created by sergio fresneda on 3/15/26.
//

import Foundation

enum WatchCommand: Codable, Hashable {
    case incrementTap(boardId: UUID)
}
