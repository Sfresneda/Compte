//
//  PlaceholderEmptyTapListDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 23/12/22.
//

import Foundation
import SwiftUI

struct PlaceholderEmptyTapListDecorator {
    private enum Constants {
        static let emptyListPlaceholderText: String = NSLocalizedString("empty_taps_message", comment: "empty taps")
        static let textFont: Font = .title2
        static let textAligment: TextAlignment = .center
        static let textForegroundColor: Color = .secondary
        static let textPadding: EdgeInsets = EdgeInsets(top: 20,
                                                        leading: 40,
                                                        bottom: .zero,
                                                        trailing: 40)

        static let imageMaxHeight: CGFloat = 80
        static let imageForegroundColor: Color = .orange.opacity(0.7)
        static let imageAnimationMaxScale: CGFloat = 1
        static let imageAnimationMinScale: CGFloat = 0.95
        static let imageName: String = "arrowshape.backward"
        static let imageRotationDegrees: Double = -90

        static let animationScaleMaxValue: Double = 1
        static let animationScaleMinValue: Double = 0.9
        static let animationDuration: Double = 1
    }
}
extension PlaceholderEmptyTapListDecorator: PlaceholderDecorator {
    func content(_ animationClosure: @autoclosure () -> Bool) -> some View {
        VStack {
            Image(systemName: "hand.tap")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: Constants.imageMaxHeight)
                .foregroundColor(Constants.imageForegroundColor)
                .scaleEffect(animationClosure()
                             ? Constants.animationScaleMaxValue
                             : Constants.animationScaleMinValue)

            Text(Constants.emptyListPlaceholderText)
                .font(.title)
                .padding(Constants.textPadding)
                .multilineTextAlignment(Constants.textAligment)
                .foregroundColor(Constants.textForegroundColor)
        }
    }
    func animation(_ animationClosure: @autoclosure () -> Void) {
        withAnimation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 1)
            .repeatForever()) {
                animationClosure()
            }
    }
}
