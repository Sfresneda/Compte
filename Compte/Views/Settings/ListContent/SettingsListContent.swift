//
//  SettingsListContent.swift
//  Compte
//
//  Created by likeadeveloper on 17/5/23.
//

import SwiftUI
import MessageUI

struct SettingsListContent: View {
    @State var focusMode: Bool
    @State var sections: [SettingsSection]

    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    var body: some View {
        ForEach(sections) { section in
            Section {
                ForEach(section.options) { option in
                    switch option.type {
                    case .link:
                        NavigationLink {
                            SettingsAppearanceView(isFocusModeEnabled: focusMode)
                        } label: {
                            optionContent(option)
                        }
                    case .externalLink:
                        if let url = option.url {
                            Link(destination: url) {
                                optionContent(option)
                            }
                        }
                    case .mail:
                        Button(action: {
                            self.isShowingMailView.toggle()
                        }) {
                            optionContent(option)
                        }        .disabled(!MFMailComposeViewController.canSendMail())
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(isShowing: $isShowingMailView,
                                         result: self.$result)
                            }
                    }
                }
            } header: {
                if let header = section.header {
                    Text(header)
                }
            } footer: {
                if let footer = section.footer {
                    Text(footer)
                }
            }
        }
    }
}
private extension SettingsListContent {
    func optionContent(_ option: SettingsOption) -> some View {
        HStack {
            if let name = option.iconName {
                Image(systemName: name)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .background(Color.fireOrange)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            Text(option.title)
                .foregroundColor(.textPrimary)
        }
    }
}


struct MailView: UIViewControllerRepresentable {

    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                isShowing = false
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}
