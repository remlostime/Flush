//
//  PublicCardsDetailsViewModel.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// MARK: - PublicCardsDetailsViewModel

@Observable
class PublicCardsDetailsViewModel {
    // MARK: Lifecycle

    init(privateCards: [Card?] = [nil, nil],
         publicCards: [ListCard?] = [nil, nil, nil, nil, nil],
         isPublicCardSelected: [Bool] = [false, false, false, false, false])
    {
        self.privateCards = privateCards
        self.publicCards = publicCards
        self.isPublicCardSelected = isPublicCardSelected
    }

    // MARK: Internal

    var privateCards: [Card?]
    var publicCards: [ListCard?]
    var isPublicCardSelected: [Bool]

    var winRate: Double {
        0.30
    }

    var winRatePercent: String {
        let rate = Int(winRate * 100.0)
        return "\(rate)%"
    }

    func resetCardSelected(forValue newValue: Bool) {
        isPublicCardSelected = isPublicCardSelected.map { _ in newValue }
    }

    func didTapCard(_ cardIndex: Int) {
        guard let publicCard = publicCards[cardIndex] else {
            return
        }

        let card = publicCard.card

        // if `selected` then we update the `kind`
        if isPublicCardSelected[cardIndex] {
            let newCard = Card(kind: card.kind.next, number: card.number)
            publicCards[cardIndex] = ListCard(card: newCard,
                                              id: publicCard.id,
                                              isSelected: publicCard.isSelected)
        } else {
            resetCardSelected(forValue: false)
            isPublicCardSelected[cardIndex] = true
        }
    }

    func didTapPlaceholderView(placeholderIndex: Int) {
        publicCards[placeholderIndex] = ListCard.initial
        resetCardSelected(forValue: false)
        isPublicCardSelected[placeholderIndex] = true
    }
}

extension PublicCardsDetailsViewModel {
    static let empty = PublicCardsDetailsViewModel()
}
