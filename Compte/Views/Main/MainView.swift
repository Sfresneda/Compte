//
//  MainView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI
import Combine

// MARK: - Lifecycle
struct MainView: View {
    // MARK: Vars
    @ObservedObject var vmodel: MainVModel
    @State private var needsToShowAlert: Bool = false
    
    // MARK: Body
    var body: some View {
        ZStack {
            MainNavbarView(name: $vmodel.name) {
                VStack {
                    ScrollViewReader { proxy in
                        Form {
                            Section("Last Taps") {
                                ForEach(vmodel.tapsCollection, id: \.id) { tap in
                                    MainViewListCell(model: tap)
                                }
                            }
                        }
                        .onChange(of: vmodel.numberOfTaps) { newValue in
                            guard let firstId = vmodel
                                .tapsCollection
                                .first?
                                .id else { return }
                            
                            withAnimation {
                                proxy.scrollTo(firstId,
                                               anchor: .bottom)
                            }
                        }
                    }
                    VStack {
                        HStack {
                            SlideToUnlockView(action: {
                                withAnimation(.easeInOut) {
                                    vmodel.cleanData()
                                }
                            })
                            Image(systemName: "trash")
                                .font(.title3)
                        }
                        .padding(EdgeInsets(top: 5,
                                            leading: 20,
                                            bottom: 5,
                                            trailing: 20))
                        TapView(action: {
                            withAnimation(.easeIn) {
                                vmodel.increaseTaps()
                            }
                        })
                    }
                }
            }
            CounterView(currentValue: $vmodel.numberOfTaps)
                .frame(maxHeight: .infinity,
                       alignment: .top)
                .shadow(radius: 20)
        }
    }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let model = MainVModel()
        model.numberOfTaps = 200
        model.tapsCollection = Array<TapModel>
            .init(repeating: TapModel(date: Date().timeIntervalSince1970,
                                      tapNumber: 1),
                  count: 20)
        return MainView(vmodel: model)
    }
}
