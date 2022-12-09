//
//  CounterView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI
// MARK: - Lifecycle
struct CounterView: View {
    // MARK: Vars
    @Binding var currentValue: Int
    
    // MARK: Body
    var body: some View {
        Text(String(currentValue))
            .bold()
            .font(.system(size: 50))
            .fontDesign(.monospaced)
            .padding()
            .background(VisualEffectView(style: .systemThickMaterial))
            .clipShape(Capsule())
    }
}

// MARK: - Preview
struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(currentValue: .constant(1))
    }
}

