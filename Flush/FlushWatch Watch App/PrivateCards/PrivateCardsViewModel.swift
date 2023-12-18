//
//  PrivateCardsViewModel.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import Foundation
import SwiftUI

// MARK: - PrivateCardsViewModel

@Observable
class PrivateCardsViewModel {
    // MARK: Lifecycle

    init(rankManager: RankManager = DefaultRankManager(),
         cards: [Card?] = [nil, nil],
         playersNumber: Int = Board.MinPlayerNumber)
    {
        self.rankManager = rankManager
        self.cards = cards
        self.playersNumber = playersNumber
        playersNumberDigitalCrown = Double(playersNumber)
    }

    // MARK: Internal

    var playersNumber: Int
    var cards: [Card?]
    var isCardSelected: [Bool] = [false, false]

    var playersNumberDigitalCrown: Double {
        didSet {
            playersNumber = Int(playersNumberDigitalCrown)
        }
    }

    var firstCardValue: Double = 1 {
        didSet {
            guard let firstCard = firstCard else {
                return
            }

            self.firstCard = Card(kind: firstCard.kind, number: Int(firstCardValue))
        }
    }

    var secondCardValue: Double = 1 {
        didSet {
            guard let secondCard = secondCard else {
                return
            }

            self.secondCard = Card(kind: secondCard.kind, number: Int(secondCardValue))
        }
    }

    var isFirstCardSelected: Bool {
        get {
            isCardSelected[0]
        }
        set {
            isCardSelected[0] = newValue
        }
    }

    var isSecondCardSelected: Bool {
        get {
            isCardSelected[1]
        }
        set {
            isCardSelected[1] = newValue
        }
    }

    var firstCard: Card? {
        get {
            cards[0]
        }
        set {
            cards[0] = newValue
        }
    }

    var secondCard: Card? {
        get {
            cards[1]
        }
        set {
            cards[1] = newValue
        }
    }

    var winRate: Double {
        rankManager.calculateWinRate(board: .init(privateCards: cards, publicCards: [], playersNumber: playersNumber))
    }

    var winRatePercent: String {
        let rate = Int(winRate * 100.0)
        return "\(rate)% Win"
    }

    func resetCardSelected(forValue newValue: Bool) {
        isCardSelected = isCardSelected.map { _ in newValue }
    }

    func didTapCard(_ cardIndex: Int) {
        guard let card = cards[cardIndex] else {
            return
        }

        // if `selected` then we update the `kind`
        if isCardSelected[cardIndex] {
            let newCard = Card(kind: card.kind.next, number: card.number)
            cards[cardIndex] = newCard
        } else {
            resetCardSelected(forValue: false)
            isCardSelected[cardIndex] = true
        }
    }

    func didTapPlaceholderView(placeholderIndex: Int) {
        cards[placeholderIndex] = Card.initialCard
        resetCardSelected(forValue: false)
        isCardSelected[placeholderIndex] = true
    }

    // MARK: Private

    private let rankManager: RankManager
}
