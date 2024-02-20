//
//  Board.swift
//  FlushModel
//
//  Created by Kai Chen on 2/20/24.
//

import Foundation

// MARK: - Board

public struct Board {
    public static let MaxPlayerNumber = 10
    public static let MinPlayerNumber = 2
    
    public var privateCards: [Card?]
    public var publicCards: [Card?]
    public var playersNumber: Int
    
    public init(privateCards: [Card?], publicCards: [Card?], playersNumber: Int) {
        self.privateCards = privateCards
        self.publicCards = publicCards
        self.playersNumber = playersNumber
    }
}

extension Board {
    public static let initial = Board(privateCards: [nil, nil],
                                      publicCards: [nil, nil, nil, nil, nil],
                                      playersNumber: 5)
}
