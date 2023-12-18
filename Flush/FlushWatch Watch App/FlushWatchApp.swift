//
//  FlushWatchApp.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

// MARK: - Board

struct Board {
    var privateCards: [Card?]
    var publicCards: [Card?]
    var playersNumber: Int

    static let MaxPlayerNumber = 10
    static let MinPlayerNumber = 2
}

extension Board {
    static let initial = Board(privateCards: [nil, nil], 
                               publicCards: [nil, nil, nil, nil, nil],
                               playersNumber: 1)
}

// MARK: - FlushWatch_Watch_AppApp

@main
struct FlushWatch_Watch_AppApp: App {
    @State var board = Board.initial

    var body: some Scene {
        WindowGroup {
            TabView {
                TabView {
                    PrivateCardsView(board: $board)
                    PrivateCardsDetailsView(board: $board)
                }
                .tabViewStyle(.carousel)

                TabView {
                    PublicCardsView(board: $board)
                    PublicCardsDetailsView(board: $board)
                }
                .tabViewStyle(.carousel)
            }
        }
    }
}
