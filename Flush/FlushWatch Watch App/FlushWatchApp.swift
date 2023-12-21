//
//  FlushWatchApp.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

// MARK: - Board

struct Board {
    static let MaxPlayerNumber = 10
    static let MinPlayerNumber = 2

    var privateCards: [Card?]
    var publicCards: [Card?]
    var playersNumber: Int
}

extension Board {
    static let initial = Board(privateCards: [nil, nil],
                               publicCards: [nil, nil, nil, nil, nil],
                               playersNumber: 5)
}

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
