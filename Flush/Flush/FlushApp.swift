//
//  FlushApp.swift
//  Flush
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

@main
struct FlushApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: .init(initialState: CardPickerFeature.State(board: .init(privateCards: [nil, nil], publicCards: [nil, nil, nil, nil, nil], playersNumber: 1)), reducer: {
                CardPickerFeature()
            }))
        }
    }
}
