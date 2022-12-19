//
//  VisualEffectView.swift
//  Compte
//
//  Created by likeadeveloper on 8/12/22.
//

import SwiftUI
struct VisualEffectView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView,
                      context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
