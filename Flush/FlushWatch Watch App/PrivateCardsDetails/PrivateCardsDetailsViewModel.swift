//
//  PrivateCardsDetailsViewModel.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// MARK: - PrivateCardsDetailsViewModel

@Observable
class PrivateCardsDetailsViewModel {
    // MARK: Lifecycle

    init(rankManager: RankManager = DefaultRankManager(),
         cards: [Card?] = [nil, nil],
         isCardSelected: [Bool] = [false, false],
         firstCardValue: Double = 1.0,
         secondCardValue: Double = 1.0,
         playersNumber: Int = 1)
    {
        self.rankManager = rankManager
        self.cards = cards
        self.isCardSelected = isCardSelected
        self.firstCardValue = firstCardValue
        self.secondCardValue = secondCardValue
        self.playersNumber = playersNumber
        playersNumberDigitalCrown = Double(playersNumber)
    }

    // MARK: Internal

    let rankManager: RankManager

    var playersNumber: Int
    var cards: [Card?]
    var isCardSelected: [Bool]

    var playersNumberDigitalCrown: Double {
        didSet {
            playersNumber = Int(playersNumberDigitalCrown)
        }
    }

    var firstCardValue: Double {
        didSet {
            guard let firstCard = firstCard else {
                return
            }

            self.firstCard = Card(kind: firstCard.kind, number: Int(firstCardValue))
        }
    }

    var secondCardValue: Double {
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
        1.0
    }

    var winRatePercent: String {
        let rate = Int(winRate * 100.0)
        return "\(rate)%"
    }

    var rankRate: [RankRate] {
        rankManager.calculateRankRate(privateCards: cards, publicCards: [])
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
}

extension PrivateCardsDetailsViewModel {
    static let empty = PrivateCardsDetailsViewModel()
}
