//
//  TapListView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI
import Combine

// MARK: - Lifecycle
struct TapListView<Model>: View where Model: TapListVModelProtocol {
    // MARK: Vars
    @ObservedObject var vmodel: Model
    @State private var needsToShowAlert: Bool = false
    
    // MARK: Body
    var body: some View {
        ZStack {
            VStack {
                ScrollViewReader { proxy in
                    Form {
                        Section("Last Taps") {
                            ForEach(vmodel.items, id: \.id) { tap in
                                MainViewListCell(model: tap)
                            }
                        }
                        .animation(.default, value: vmodel.items)
                    }
                    .onChange(of: vmodel.numberOfTaps) { newValue in
                        guard let firstId = vmodel.items.first?.id else { return }

                        withAnimation(.easeOut) {
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
                        vmodel.add()
                    })
                }
            }
            .safeAreaInset(edge: .top) {
                withAnimation {
                    CounterView(currentValue: $vmodel.numberOfTaps)
                        .clipShape(Capsule())
                        .padding(EdgeInsets(top: .zero,
                                            leading: 40,
                                            bottom: .zero,
                                            trailing: 40))
                        .scaledToFit()
                        .frame(maxHeight: 80)
                }
            }
        }
        .toolbar(.visible, for: .navigationBar)
        .navigationTitle(vmodel.name)
    }
}
// MARK: - Helpers
private extension TapView {}
// MARK: - Preview
struct TapListView_Previews: PreviewProvider {
    static var previews: some View {
        let model = TapListVModel(modelObject: CompteObject.defaultImplementation())
        model.numberOfTaps = 1
        model.items = Array<TapObject>
            .init(repeating: TapObject(date: Date().timeIntervalSince1970,
                                       tapNumber: 1),
                  count: 1)
        return TapListView(vmodel: model)
    }
}
