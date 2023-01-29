//
//  BoardScrollDecoratorMock.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import Foundation
import SwiftUI
@testable import Compte

struct BoardScrollDecoratorMock {}
extension BoardScrollDecoratorMock: BoardScrollDecorator {
    var listRowInsets: EdgeInsets {
        .init(.zero)
    }
    var listRowBackground: Color {
        .clear
        .opacity(0.5)
    }
    var backgroundColor: Color {
        .clear
        .opacity(0.5)
    }
}
