//
//  PrivateCardsViewModel.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import Foundation

// MARK: - PrivateCardsViewModel

@Observable
class PrivateCardsViewModel {
    var cards: [Card?] = [nil, nil]
    var isCardSelected: [Bool] = [false, false]

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
        guard let firstCard = firstCard, let secondCard = secondCard else {
            return 0.0
        }

        return Double(firstCard.number + secondCard.number + firstCard.kind.rawValue + secondCard.kind.rawValue)
    }

    var winRatePercent: String {
        let rate = Int(winRate * 100.0)
        return "\(rate)%"
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
