//
//  RankManager.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

protocol RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double
}

class RoyalFlushRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class StraightFlushRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class FourKindRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class FullHouseRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class FlushRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class StraightRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class ThreeKindRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class TwoPairsRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class PairRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

class HighCardRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0...1)
    }
}

struct RankRate: Identifiable {
    let rank: Rank
    let rate: Double

    var id: Rank {
        rank
    }
}

protocol RankManager {
    func calculateRankRate() -> [RankRate]
}

class DefaultRankManager: RankManager {
    private let privateCards: [Card?]
    private let publicCards: [Card?]

    init(privateCards: [Card?], publicCards: [Card?]) {
        self.privateCards = privateCards
        self.publicCards = publicCards
    }

    func rankRateCalculator(for rank: Rank) -> RankRateCalculator {
        switch rank {
        case .royalFlush:
            return RoyalFlushRater()
        case .straightFlush:
            return StraightRater()
        case .fourKind:
            return FourKindRater()
        case .fullHouse:
            return FullHouseRater()
        case .flush:
            return FlushRater()
        case .straight:
            return StraightRater()
        case .threeKind:
            return ThreeKindRater()
        case .twoPairs:
            return TwoPairsRater()
        case .pair:
            return PairRater()
        case .highCard:
            return HighCardRater()
        }
    }

    func calculateRankRate() -> [RankRate] {
        let ranks = Rank.allCases
        let rankRate = ranks.map { rank in
            let rater = rankRateCalculator(for: rank)
            let rate = rater.calculateRate(privateCards: privateCards, publicCards: publicCards)

            return RankRate(rank: rank, rate: rate)
        }

        return rankRate
    }
}
