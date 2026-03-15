//
//  WCCodec.swift
//  Compte
//
//  Created by sergio fresneda on 3/15/26.
//

import Foundation

enum WCCodec {
    static func encodePayload(_ payload: WatchPayload) throws -> [String: Any] {
        let data = try JSONEncoder().encode(payload)
        return ["payload": data]
    }

    static func decodePayload(_ dictionary: [String: Any]) throws -> WatchPayload {
        guard let data = dictionary["payload"] as? Data else {
            throw WCCodecError.invalidData
        }
        return try JSONDecoder().decode(WatchPayload.self, from: data)
    }

    static func encodeCommand(_ command: WatchCommand) throws -> [String: Any] {
        let data = try JSONEncoder().encode(command)
        return ["command": data]
    }

    static func decodeCommand(_ dictionary: [String: Any]) throws -> WatchCommand {
        guard let data = dictionary["command"] as? Data else {
            throw WCCodecError.invalidData
        }
        return try JSONDecoder().decode(WatchCommand.self, from: data)
    }
}
