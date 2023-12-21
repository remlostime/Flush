//
//  ListCard.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// wrapper for `Card` which can be used in List
struct ListCard: Identifiable, Hashable {
    // MARK: Lifecycle

    init(card: Card, id: UUID) {
        self.card = card
        self.id = id
    }

    // MARK: Internal

    static let initial = ListCard(card: .initialCard, id: UUID())

    let card: Card
    let id: UUID

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
