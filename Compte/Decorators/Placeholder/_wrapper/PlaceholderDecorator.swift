//
//  PlaceholderDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 23/12/22.
//

import Foundation
import SwiftUI

protocol PlaceholderDecorator {
    associatedtype Content: View

    func content(_ animationClosure: @escaping @autoclosure (() -> Bool)) -> Content
    func animation(_ animationClosure: @autoclosure (() -> Void))
}
