//
//  ListCard.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// wrapper for `Card` which can be used in List
public struct ListCard: Identifiable, Hashable {
    // MARK: Lifecycle

    public init(card: Card, id: UUID) {
        self.card = card
        self.id = id
    }

    // MARK: Internal

    public static let initial = ListCard(card: .initialCard, id: UUID())

    public let card: Card
    public let id: UUID

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
