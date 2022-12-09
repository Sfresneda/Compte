//
//  MainNavbarView.swift
//  Compte
//
//  Created by likeadeveloper on 8/12/22.
//

import SwiftUI

struct MainNavbarView<Content>: View where Content: View {
    @Binding var name: String
    @ViewBuilder var content: Content
    var body: some View {
        NavigationView {
            content
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle(name)
        }
    }
}

struct MainNavbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavbarView(name: .constant("something")) {
            Text("something")
        }
    }
}
