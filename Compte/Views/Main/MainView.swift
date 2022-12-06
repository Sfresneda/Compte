//
//  MainView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - Lifecycle
struct MainView: View {
    // MARK: Vars
    @ObservedObject var vmodel: MainVModel
    @State private var needsToShowAlert: Bool = false
    
    // MARK: Body
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Last Taps") {
                        ForEach(vmodel.tapsCollection, id: \.id) { tap in
                            Text(tap.id.uuidString)
                        }
                    }
                }
                VStack(alignment: .center) {
                    CounterView(currentValue: $vmodel.numberOfTaps)
                    TapView().actionOnComplete {
                        vmodel.increaseTaps()
                    }
                }
                .background(ignoresSafeAreaEdges: .bottom)
            }
            .navigationTitle(vmodel.screenName)
            .toolbar {
                MainNavbarView()
                    .onTapSomeButton { triggeredButton in
                        debugPrint("\(triggeredButton)")
                    }
            }
        }
    }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let model = MainVModel()
        model.tapsCollection = [
            TapModel(date: Date().timeIntervalSince1970,
                     tapNumber: 1)
        ]
        return MainView(vmodel: model)
    }
}
