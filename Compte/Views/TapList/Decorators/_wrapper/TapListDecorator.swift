//
//  TapListDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol TapListDecorator {
    var sectionTitle: String { get }
    var scrollToTopAnimation: Animation { get }
    var slideToUnlockAnimation: Animation { get }
    var slideToUnlockImageName: String { get }
    var slideToUnlockImageFont: Font { get }
    var slideToUnlockPadding: EdgeInsets { get }
    var tapButtonFont: Font { get }
    var tapButtonMaxWidth: CGFloat { get }
    var tapButtonBackgroundColor: Color { get }
    var counterViewPadding: EdgeInsets { get }
    var counterViewMaxHeight: CGFloat { get }
}

extension TapListDecorator {
    var sectionTitle: String {
        NSLocalizedString("section_title_last_taps", comment: "last taps section title")
    }
    var scrollToTopAnimation: Animation {
        .easeOut
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
        .blue
    }
    var counterViewPadding: EdgeInsets {
        EdgeInsets(top: .zero, leading: 40, bottom: .zero, trailing: 40)
    }
    var counterViewMaxHeight: CGFloat {
        80
    }
}
