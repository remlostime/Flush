//
//  ResultViewModel.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation
import SwiftUI

// MARK: - ResultViewModel

@Observable
class ResultViewModel {
    // MARK: Lifecycle

    init(board: Board, rankManager: RankManager = DefaultRankManager()) {
        self.rankManager = rankManager
        self.board = board
    }

    // MARK: Internal

    let board: Board

    let rankManager: RankManager

    var privateCards: [Card?] {
        board.privateCards
    }

    var publicCards: [Card?] {
        board.publicCards
    }

    var winRate: Double {
        rankManager.calculateWinRate(board: board)
    }

    var winRatePercent: String {
        let rate = Int(winRate * 100.0)
        return "\(rate)% Win"
    }

    var rankRate: [RankRate] {
        rankManager.calculateRankRate(privateCards: privateCards, publicCards: publicCards)
    }
}

extension ResultViewModel {
    static let empty = ResultViewModel(board: .initial)
}
