//
//  RankManager.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// MARK: - RankRate

struct RankRate: Identifiable {
    let rank: Rank
    let rate: Double

    var id: Rank {
        rank
    }
}

// MARK: - RankManager

protocol RankManager {
    func calculateRankRate(privateCards: [Card?], publicCards: [Card?]) -> [RankRate]
    func calculateWinRate(board: Board) -> Double
}

// MARK: - DefaultRankManager

class DefaultRankManager: RankManager {
    // MARK: Internal

    func rankChecker(for rank: Rank) -> RankChecker {
        switch rank {
            case .royalFlush:
                return RoyalFlushChecker()
            case .straightFlush:
                return StraightChecker()
            case .fourKind:
                return FourKindChecker()
            case .fullHouse:
                return FullHouseChecker()
            case .flush:
                return FlushChecker()
            case .straight:
                return StraightChecker()
            case .threeKind:
                return ThreeKindChecker()
            case .twoPairs:
                return TwoPairsChecker()
            case .pair:
                return PairChecker()
            case .highCard:
                return HighCardChecker()
        }
    }

    func rankBuilder(for rank: Rank) -> RankBuilder {
        switch rank {
            case .royalFlush:
                return RoyalFlushBuilder()
            case .straightFlush:
                return StraightFlushBuilder()
            case .fourKind:
                return FourKindBuilder()
            case .fullHouse:
                return FullHouseBuilder()
            case .flush:
                return FlushBuilder()
            case .straight:
                return StraightBuilder()
            case .threeKind:
                return ThreeKindBuilder()
            case .twoPairs:
                return TwoPairsBuilder()
            case .pair:
                return PairBuilder()
            case .highCard:
                return HighCardBuilder()
        }
    }

    func calculateRankRate(privateCards: [Card?], publicCards: [Card?]) -> [RankRate] {
        let ranks = Rank.allCases
        var rankRateCount: [Rank: Int] = [:]

        for rank in ranks {
            rankRateCount[rank] = 0
        }

        for _ in 0 ..< simulateTimes {
            let (privateCards, publicCards) = simulatePossibleCards(privateCards: privateCards, publicCards: publicCards)

            for rank in ranks {
                let rankChecker = rankChecker(for: rank)
                let isValidCount = rankChecker.isValid(privateCards: privateCards, publicCards: publicCards) ? 1 : 0
                let count = rankRateCount[rank] ?? 0
                rankRateCount[rank] = count + isValidCount
            }
        }

        let rankRate = rankRateCount.map { rank, val in
            let rate = Double(val) / Double(simulateTimes)

            return RankRate(rank: rank, rate: rate)
        }.sorted { rank1, rank2 in
            rank1.rank.rawValue < rank2.rank.rawValue
        }

        return rankRate
    }

    private func compareCards(for rank: Rank) -> CompareCards {
        switch rank {
        case .royalFlush:
            return RoyalFlushComparer()
        case .straightFlush:
            return StraightComparer()
        case .fourKind:
            return FourKindComparer()
        case .fullHouse:
            return FullHouseComparer()
        case .flush:
            return FlushComparer()
        case .straight:
            return StraightComparer()
        case .threeKind:
            return ThreeKindComparer()
        case .twoPairs:
            return TwoPairsComparer()
        case .pair:
            return PairComparer()
        case .highCard:
            return HighCardComparer()
        }
    }

    private func compareCards(myCards: [Card],
                              otherPlayerCards: [Card],
                              publicCards: [Card],
                              for rank: Rank) -> CompareResult
    {
        let rankBuilder = rankBuilder(for: rank)
        let myCards = rankBuilder.build(privateCards: myCards, publicCards: publicCards)
        let otherCards = rankBuilder.build(privateCards: otherPlayerCards, publicCards: publicCards)
        let compareCards = compareCards(for: rank)

        return compareCards.compare(myCards: myCards, to: otherCards)
    }

    private func compareCards(myCards: [Card], otherPlayerCards: [Card], publicCards: [Card]) -> CompareResult {
        let ranks = Rank.allCases
        for rank in ranks {
            let rankChecker = rankChecker(for: rank)
            let isValidForMyCards = rankChecker.isValid(privateCards: myCards, publicCards: publicCards)
            let isValidForOtherPlayerCards = rankChecker.isValid(privateCards: otherPlayerCards, publicCards: publicCards)

            switch (isValidForMyCards, isValidForOtherPlayerCards) {
                case (true, true):
                    return compareCards(myCards: myCards,
                                        otherPlayerCards: otherPlayerCards,
                                        publicCards: publicCards,
                                        for: rank)
                case (true, false):
                    return .win
                case (false, true):
                    return .lose
                case (false, false):
                    break
            }
        }

        let sortedMyCards = (myCards + publicCards).sorted()[0..<Card.HandCardsNumber]
        let sortedOtherPlayerCards = (otherPlayerCards + publicCards).sorted()[0..<Card.HandCardsNumber]

        for i in 0..<Card.HandCardsNumber {
            if sortedMyCards[i].number == sortedOtherPlayerCards[i].number {
                continue
            } else if sortedMyCards[i].number < sortedOtherPlayerCards[i].number {
                return .lose
            } else {
                return .win
            }
        }

        return .tie
    }

    func calculateWinRate(board: Board) -> Double {
        var count = 0
        for _ in 0..<simulateTimes {
            let (privateCards, publicCards, otherPlayersCards) = simulatePossibleCards(board: board)
            var win = true
            for otherPlayersCard in otherPlayersCards {
                let result = compareCards(myCards: privateCards, otherPlayerCards: otherPlayersCard, publicCards: publicCards)
                if result != .win {
                    win = false
                    break
                }
            }

            count += win ? 1 : 0
        }

        return Double(count) / Double(simulateTimes)
    }

    // MARK: Private

    private let simulateTimes = 10000

    private func simulatePossibleCards(board: Board) -> (privateCards: [Card], publicCards: [Card], otherPlayersCards: [[Card]]) {
        let (privateCards, publicCards) = simulatePossibleCards(privateCards: board.privateCards, publicCards: board.publicCards)

        var cards = Set(privateCards + publicCards)

        var otherPlayersCards: [[Card]] = []

        for index in 0 ..< (board.playersNumber - 1) {
            otherPlayersCards.append([])
            for _ in 0..<2 {
                var card = Card.random
                while cards.contains(card) {
                    card = Card.random
                }
                cards.insert(card)

                otherPlayersCards[index].append(card)
            }
        }

        return (privateCards: privateCards, publicCards: publicCards, otherPlayersCards: otherPlayersCards)
    }

    private func simulatePossibleCards(privateCards: [Card?], publicCards: [Card?]) -> (privateCards: [Card], publicCards: [Card]) {
        var cards = (privateCards + publicCards).compactMap { $0 }
        let needCardsNumber = Card.AllCardsTotalNumber - cards.count

        var simulatedPrivateCards = privateCards.compactMap { $0 }
        var simulatedPublicCards = publicCards.compactMap { $0 }

        for _ in 0 ..< needCardsNumber {
            var card = Card.random
            while cards.contains(card) {
                card = Card.random
            }
            cards.append(card)

            if simulatedPrivateCards.count < Card.PrivateCardsTotalNumber {
                simulatedPrivateCards.append(card)
            } else if simulatedPublicCards.count < Card.PublicCardsTotalNumber {
                simulatedPublicCards.append(card)
            }
        }

        return (privateCards: simulatedPrivateCards, publicCards: simulatedPublicCards)
    }
}
