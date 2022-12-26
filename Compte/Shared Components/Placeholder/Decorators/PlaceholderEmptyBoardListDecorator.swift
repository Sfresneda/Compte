//
//  PlaceholderEmptyBoardListDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 23/12/22.
//

import Foundation
import SwiftUI

struct PlaceholderEmptyBoardListDecorator {
    private enum Constants {
        static let imageName: String = "plus.square.dashed"
        static let imageMaxWidth: CGFloat = 120
        static let imageForegroundColor: Color = .fireOrange
        static let imageAnimationMaxScale: CGFloat = 1
        static let imageAnimationMinScale: CGFloat = 0.95

        static let emptyMessage: String = NSLocalizedString("empty_boards_message",
                                                            comment: "This seems to be too empty, start adding a new board.")
        static let textFont: Font = .title2
        static let textPadding: EdgeInsets = EdgeInsets(top: 20,
                                                        leading: 40,
                                                        bottom: .zero,
                                                        trailing: 40)
        static let textAligment: TextAlignment = .center
        static let textForegroundColor: Color = .textPrimary

        static let animationDuration: Double = 1
    }
}
extension PlaceholderEmptyBoardListDecorator: PlaceholderDecorator {
    func content(_ animationClosure: @autoclosure () -> Bool) -> some View {
        VStack {
            Image(systemName: Constants.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: Constants.imageMaxWidth)
                .foregroundColor(Constants.imageForegroundColor)
                .scaleEffect(animationClosure()
                             ? Constants.imageAnimationMaxScale
                             : Constants.imageAnimationMinScale)
            Text(Constants.emptyMessage)
                .font(Constants.textFont)
                .padding(Constants.textPadding)
                .multilineTextAlignment(Constants.textAligment)
                .foregroundColor(Constants.textForegroundColor)
        }
    }
    func animation(_ animationClosure: @autoclosure () -> Void) {
        withAnimation(.easeInOut(duration: Constants.animationDuration)
            .repeatForever(autoreverses: true)) {
            animationClosure()
        }
    }
}
