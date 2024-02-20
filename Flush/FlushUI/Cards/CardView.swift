//
//  CardView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI
import FlushModel

// MARK: - CardView

public struct CardView: View {
    // MARK: Lifecycle

    public init(card: Card) {
        self.card = card
    }

    // MARK: Internal

    let card: Card

    public var body: some View {
        ZStack {
            VStack {
                Text(card.number.cardNumber)
                Image(systemName: card.kind.imageName)
            }
            .foregroundStyle(card.kind.color)

            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5),
                             style: .circular)
                .strokeBorder(.primary)
                .aspectRatio(0.74, contentMode: .fit)
        }
    }
}

#Preview("Heart-A") {
    CardView(card: .heartA)
}

#Preview("Spade-K") {
    CardView(card: .spadeK)
}
