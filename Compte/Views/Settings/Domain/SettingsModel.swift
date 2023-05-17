//
//  SettingsModel.swift
//  Compte
//
//  Created by likeadeveloper on 17/5/23.
//

import Foundation

enum SettingsSection: String, CaseIterable, Identifiable {
    var id: String {
        rawValue
    }

    case appearance
    case extra

    var header: String? {
        switch self {
        case .appearance:
            return rawValue
        case .extra:
            return nil
        }
    }

    var footer: String? {
        switch self {
        case .appearance:
            return nil
        case .extra:
            return nil
        }
    }

    var options: [SettingsOption] {
        switch self {
        case .appearance:
            return [.tapList]
        case .extra:
            return [.github, .contact, .about]
        }
    }
}
enum SettingsOption: String, CaseIterable, Identifiable {
    var id: String {
        rawValue
    }
    case tapList = "tap list"

    case github = "this project in Github"
    case about = "about me"
    case contact

    var title: String {
        rawValue.capitalized
    }
    var iconName: String? {
        switch self {
        case .tapList:
            return "hand.tap.fill"
        case .github:
            return "arrow.triangle.branch"
        case .about:
            return "questionmark.circle.fill"
        case .contact:
            return "envelope.fill"
        }
    }

    var type: SettingsOptionType {
        switch self {
        case .tapList:
            return .link
        case .github,
                .about:
            return .externalLink
        case .contact:
            return .mail
        }
    }

    var url: URL? {
        switch self {
        case .about:
            return URL(string: "https://sergiofresneda.com")
        case .github:
            return URL(string: "https://github.com/Sfresneda/Compte")
        default:
            return nil
        }
    }
}

enum SettingsOptionType {
    case link
    case externalLink
    case mail
}
