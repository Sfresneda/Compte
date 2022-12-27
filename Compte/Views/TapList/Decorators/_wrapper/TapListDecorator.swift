//
//  TapListDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol TapListDecorator {
    var viewBackgroundColor: Color { get }

    var sectionTitle: String { get }
    var sectionForegroundColor: Color { get }
    var scrollToTopAnimation: Animation { get }
    var listRowBackgroundColor: Color { get }

    var slideToUnlockAnimation: Animation { get }
    var slideToUnlockImageName: String { get }
    var slideToUnlockImageFont: Font { get }
    var slideToUnlockPadding: EdgeInsets { get }

    var tapButtonFont: Font { get }
    var tapButtonMaxWidth: CGFloat { get }
    var tapButtonBackgroundColor: Color { get }

    var counterViewPadding: EdgeInsets { get }
    var counterViewMaxHeight: CGFloat { get }

    var trashButtonColor: Color { get }
}

extension TapListDecorator {
    var viewBackgroundColor: Color {
        Color.grayBackground
    }
    var sectionTitle: String {
        NSLocalizedString("section_title_last_taps", comment: "last taps section title")
    }
    var sectionForegroundColor: Color {
        Color.textPrimary
    }
    var scrollToTopAnimation: Animation {
        .easeOut
    }
    var listRowBackgroundColor: Color {
        Color.suplementaryBackground
    }
    var slideToUnlockAnimation: Animation {
        .easeInOut
    }
    var slideToUnlockImageName: String {
        "trash"
    }
    var slideToUnlockImageFont: Font {
        .title3
    }
    var slideToUnlockPadding: EdgeInsets {
        EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
    }
    var tapButtonFont: Font {
        .system(size: 50)
    }
    var tapButtonMaxWidth: CGFloat {
        .infinity
    }
    var tapButtonBackgroundColor: Color {
        .fireOrange
    }
    var counterViewPadding: EdgeInsets {
        EdgeInsets(top: .zero, leading: 40, bottom: .zero, trailing: 40)
    }
    var counterViewMaxHeight: CGFloat {
        80
    }
    var trashButtonColor: Color {
        Color.textPrimary
    }
}
