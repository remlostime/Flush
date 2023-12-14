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

    init(card: Card, id: UUID, isSelected: Bool) {
        self.card = card
        self.id = id
        self.isSelected = isSelected
    }

    // MARK: Internal

    static let initial = ListCard(card: .initialCard, id: UUID(), isSelected: false)

    let card: Card
    let id: UUID
    let isSelected: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
