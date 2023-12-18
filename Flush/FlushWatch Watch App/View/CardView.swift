//
//  CardView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

// MARK: - CardView

struct CardView: View {
    // MARK: Lifecycle

    init(card: Card, isSelected: Bool) {
        self.card = card
        self.isSelected = isSelected
    }

    // MARK: Internal

    let isSelected: Bool

    let card: Card

    var body: some View {
        ZStack {
            VStack {
                Text(card.number.cardNumber)
                Image(systemName: card.kind.imageName)
            }
            .foregroundStyle(card.kind.color)

            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5),
                             style: .circular)
                .strokeBorder(isSelected ? .cyan : .primary, lineWidth: 1)
                .aspectRatio(0.74, contentMode: .fit)
        }
    }
}

#Preview("Heart-A") {
    CardView(card: .heartA, isSelected: false)
}

#Preview("Spade-K") {
    CardView(card: .spadeK, isSelected: true)
}

#Preview("Dimond-3") {
    CardView(card: .dimond3, isSelected: false)
}

#Preview("Club-Q") {
    CardView(card: .clubQ, isSelected: false)
}
