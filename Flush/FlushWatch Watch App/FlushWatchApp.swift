//
//  FlushWatchApp.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

@main
struct FlushWatch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                TabView {
                    PrivateCardsView()
                    PrivateCardsDetailsView(viewModel: .empty)
                }
                .tabViewStyle(.carousel)

                TabView {
                    PublicCardsView()
                    PublicCardsDetailsView(viewModel: .empty)
                }
                .tabViewStyle(.carousel)
            }
        }
    }
}
