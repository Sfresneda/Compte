//
//  TapModel.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import Foundation

struct TapModel {
    let id = UUID()
    var date: TimeInterval
    var tapNumber: Int
}

extension TapModel: Hashable {}
