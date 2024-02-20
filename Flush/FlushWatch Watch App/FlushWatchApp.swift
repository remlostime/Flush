//
//  FlushWatchApp.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI
import FlushModel

// MARK: - FlushWatch_Watch_AppApp

@main
struct FlushWatch_Watch_AppApp: App {
    @State var board = Board.initial

    var body: some Scene {
        WindowGroup {
            TabView {
                CardsPickerView(board: $board)
                ResultView(board: $board)
            }
        }
    }
}
