//
//  RankChecker.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/14/23.
//

import Foundation

// MARK: - RankChecker

protocol RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool
}

// MARK: - RoyalFlushChecker

struct RoyalFlushChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        var kindsCount: [Kind: Int] = [:]
        for card in cards {
            let count = kindsCount[card.kind] ?? 0
            kindsCount[card.kind] = count + 1
        }

        let kind = kindsCount.reduce(Kind.club) { partialResult, kindCount in
            let count = kindsCount[partialResult] ?? 0
            if kindCount.value > count {
                return kindCount.key
            } else {
                return partialResult
            }
        }

        let filteredCards = cards.filter { $0.kind == kind }

        guard filteredCards.count >= Card.HandCardsNumber else {
            return false
        }

        let cardsNumbers = Set(filteredCards.map { $0.number })
        let straightNumbers: [Number] = [.ten, .jack, .queen, .king, .ace]

        for number in straightNumbers {
            if cardsNumbers.contains(number) {
                continue
            } else {
                return false
            }
        }

        return true
    }
}

// MARK: - StraightFlushChecker

struct StraightFlushChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        var kindsCount: [Kind: Int] = [:]
        for card in cards {
            let count = kindsCount[card.kind] ?? 0
            kindsCount[card.kind] = count + 1
        }

        let kind = kindsCount.reduce(Kind.club) { partialResult, kindCount in
            let count = kindsCount[partialResult] ?? 0
            if kindCount.value > count {
                return kindCount.key
            } else {
                return partialResult
            }
        }

        let filteredCards = cards.filter { $0.kind == kind }

        guard filteredCards.count >= Card.HandCardsNumber else {
            return false
        }

        let cardsNumbers = Set(filteredCards.map { $0.number })

        guard cardsNumbers.count >= Card.HandCardsNumber else {
            return false
        }
        
        return isValid(for: cardsNumbers.sorted()) || isValid(for: cardsNumbers.sorted { $0.rawValue < $1.rawValue })
    }

    private func isValid(for numbers: [Number]) -> Bool {
        for i in 0..<numbers.count {
            guard i + 1 <= numbers.count else {
                break
            }
            
            var count = 1
            for j in i+1..<numbers.count {
                if numbers[j] == numbers[j-1].next {
                    count += 1
                } else {
                    break
                }
            }
            if count == Card.HandCardsNumber {
                return true
            }
        }

        return false
    }
}

// MARK: - FourKindChecker

struct FourKindChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        for val in numbersCount.values {
            if val == 4 {
                return true
            }
        }

        return false
    }
}

// MARK: - FullHouseChecker

struct FullHouseChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        var counts: [Int: Int] = [:]
        for value in numbersCount.values {
            let count = counts[value] ?? 0
            counts[value] = count + 1
        }

        let threeKindCount = counts[3] ?? 0
        let twoKindCount = counts[2] ?? 0

        return threeKindCount > 0 && twoKindCount > 0
    }
}

// MARK: - FlushChecker

struct FlushChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        var kindsCount: [Kind: Int] = [:]
        for card in cards {
            let count = kindsCount[card.kind] ?? 0
            kindsCount[card.kind] = count + 1
        }

        for kind in Kind.allCases {
            let count = kindsCount[kind] ?? 0
            if count == Card.HandCardsNumber {
                return true
            }
        }

        return false
    }
}

// MARK: - StraightChecker

struct StraightChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        let cardsNumbers = Set(cards.map { $0.number })

        guard cardsNumbers.count >= Card.HandCardsNumber else {
            return false
        }

        return isValid(for: cardsNumbers.sorted()) || isValid(for: cardsNumbers.sorted { $0.rawValue < $1.rawValue })
    }

    private func isValid(for numbers: [Number]) -> Bool {
        for i in 0..<numbers.count {
            guard i + 1 <= numbers.count else {
                break
            }

            var count = 1
            for j in i+1..<numbers.count {
                if numbers[j] == numbers[j-1].next {
                    count += 1
                } else {
                    break
                }
            }
            if count == Card.HandCardsNumber {
                return true
            }
        }

        return false
    }
}

// MARK: - ThreeKindChecker

class ThreeKindChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        for val in numbersCount.values {
            if val >= 3 {
                return true
            }
        }

        return false
    }
}

// MARK: - TwoPairsChecker

struct TwoPairsChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        var count = 0
        for val in numbersCount.values {
            count += val / 2
        }

        return count >= 2
    }
}

// MARK: - PairChecker

struct PairChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        for val in numbersCount.values {
            if val >= 2 {
                return true
            }
        }

        return false
    }
}

// MARK: - HighCardChecker

// High cards is defined as J, Q, K, A
struct HighCardChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return false
        }

        let highCardNumbers: Set<Number> = Set([.jack, .queen, .king, .ace])
        for card in cards {
            if highCardNumbers.contains(card.number) {
                return true
            }
        }

        return false
    }
}
