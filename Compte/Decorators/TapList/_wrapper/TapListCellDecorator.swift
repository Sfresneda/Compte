//
//  TapListCellDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol TapListCellDecorator {
    var tapNumberFont: Font { get }
    var tapNumberColor: Color { get }
    var tapNumberPadding: EdgeInsets { get }
    var topDateStyle: Date.FormatStyle { get }
    var topDateFont: Font { get }
    var secondaryDateStyle: Text.DateStyle { get }
    var secondaryDateFont: Font { get }
    var secondaryDateFontColor: Color { get }
}
extension TapListCellDecorator {
    var tapNumberFont: Font {
        .system(size: 50)
    }
    var tapNumberColor: Color {
        Color.textPrimary
    }
    var tapNumberPadding: EdgeInsets {
        EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: .zero)
    }
    var topDateStyle: Date.FormatStyle {
        Date.FormatStyle().hour().minute().second()
    }
    var topDateFont: Font {
        .title2
    }
    var secondaryDateStyle: Text.DateStyle {
        .date
    }
    var secondaryDateFont: Font {
        .title3
    }
    var secondaryDateFontColor: Color {
        .textSecondary
    }
}
