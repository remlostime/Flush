//
//  RankBuilder.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/16/23.
//

import Foundation

// MARK: - RankBuilder

protocol RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card]
}

// MARK: - RoyalFlushBuilder

class RoyalFlushBuilder: RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
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

        let straightNumbers: [Number] = [.ten, .jack, .queen, .king, .ace]
        let filteredCards = cards.filter { $0.kind == kind && straightNumbers.contains($0.number) }

        guard filteredCards.count >= Card.HandCardsNumber else {
            return []
        }

        return filteredCards
    }
}

// MARK: - StraightFlushBuilder

class StraightFlushBuilder: RankBuilder {
    // MARK: Internal

    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
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
            return []
        }

        let sortedFilterCards1 = filteredCards.sorted { $0.number < $1.number }
        let sortedFilterCards2 = filteredCards.sorted { $0.number.rawValue < $1.number.rawValue }

        let sortedFilterCardsStraight1 = build(for: sortedFilterCards1)
        let sortedFilterCardsStraight2 = build(for: sortedFilterCards2)

        if sortedFilterCardsStraight1.count == Card.HandCardsNumber {
            return sortedFilterCardsStraight1
        }

        if sortedFilterCardsStraight2.count == Card.HandCardsNumber {
            return sortedFilterCardsStraight2
        }

        return []
    }

    // MARK: Private

    private func build(for cards: [Card]) -> [Card] {
        var result: [Card] = []
        for i in 0 ..< cards.count {
            guard i + 1 <= cards.count else {
                break
            }

            var count = 1
            for j in i + 1 ..< cards.count {
                let number1 = cards[j].number
                let number2 = cards[j - 1].number
                if number1 == number2.next {
                    count += 1
                } else {
                    break
                }
            }

            if count == Card.HandCardsNumber {
                result = Array(cards[i ..< (count + i)])
            }
        }

        return result
    }
}

// MARK: - FourKindBuilder

class FourKindBuilder: RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        for (key, val) in numbersCount {
            if val == 4 {
                var kindCards = Kind.allCases.map {
                    Card(kind: $0, number: key)
                }

                if let card = cards.first(where: { $0.number != key }) {
                    kindCards.append(card)
                }

                return kindCards
            }
        }

        return []
    }
}

// MARK: - FullHouseBuilder

class FullHouseBuilder: RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        var twoCards: [[Card]] = []
        var threeCards: [[Card]] = []
        for key in numbersCount.keys.sorted() {
            let count = numbersCount[key]
            if count == 2 {
                let _cards = cards.filter { $0.number == key }
                twoCards.append(_cards)
            }
            if count == 3 {
                let _cards = cards.filter { $0.number == key }
                threeCards.append(_cards)
            }
        }

        var result: [Card] = []
        if let _threeCards = threeCards.last {
            result.append(contentsOf: _threeCards)
            threeCards.removeLast()
        } else {
            return []
        }

        var _twoCards: [Card] = []

        if let _threeCards = threeCards.last {
            _twoCards = Array(_threeCards[0 ..< 2])
        }

        if let _lastTwoCards = twoCards.last {
            if let number1 = _lastTwoCards.first?.number, let number2 = _twoCards.first?.number, number1 > number2 {
                _twoCards = _lastTwoCards
            }
        }

        result.append(contentsOf: _twoCards)

        return result.count == Card.HandCardsNumber ? result : []
    }
}

// MARK: - FlushBuilder

class FlushBuilder: RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
        }

        var kindsCount: [Kind: Int] = [:]
        for card in cards {
            let count = kindsCount[card.kind] ?? 0
            kindsCount[card.kind] = count + 1
        }

        var targetKind: Kind? = nil
        for kind in Kind.allCases {
            let count = kindsCount[kind] ?? 0
            if count >= Card.HandCardsNumber {
                targetKind = kind
            }
        }

        guard let targetKind else {
            return []
        }

        let result = Array(cards.filter { $0.kind == targetKind }.sorted().reversed()[0 ..< Card.HandCardsNumber])

        return result
    }
}

// MARK: - StraightBuilder

class StraightBuilder: RankBuilder {
    // MARK: Internal

    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
        }

        let sortedCards = cards.sorted()

        let sortedCards1 = build(for: cards.sorted())
        let sortedCards2 = build(for: cards.sorted { $0.number.rawValue < $1.number.rawValue })

        if sortedCards1.isEmpty && sortedCards2.isEmpty {
            return []
        }

        if sortedCards1.isEmpty {
            return sortedCards2
        }

        if sortedCards2.isEmpty {
            return sortedCards1
        }

        if let first1 = sortedCards1.first, let first2 = sortedCards2.first {
            if first1 > first2 {
                return sortedCards1
            }

            return sortedCards2
        }

        return []
    }

    // MARK: Private

    private func build(for cards: [Card]) -> [Card] {
        var result: [Card] = []
        for i in 0 ..< cards.count {
            var currentResult: [Card] = []
            currentResult.append(cards[i])
            var j = i + 1
            while j < cards.count {
                let number = currentResult.last?.number
                if cards[j].number == number?.next {
                    currentResult.append(cards[j])
                } else {
                    break
                }
                if currentResult.count == Card.HandCardsNumber {
                    break
                }

                j += 1
            }

            if currentResult.count == Card.HandCardsNumber {
                result = currentResult
            }
        }

        return result
    }
}

// MARK: - ThreeKindBuilder

class ThreeKindBuilder: RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        var number: Number?
        for (key, val) in numbersCount {
            if val >= 3 {
                number = key
            }
        }

        guard let number else {
            return []
        }

        var result = cards.filter { $0.number == number }

        let leftCount = Card.HandCardsNumber - result.count

        var candidates = Array(cards.filter { $0.number != number }.sorted().reversed())

        for _ in 0 ..< leftCount {
            if let first = candidates.first {
                result.append(first)
                candidates.removeFirst()
            }
        }

        return result
    }
}

// MARK: - TwoPairsBuilder

class TwoPairsBuilder: RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        var count = 0
        var numbers: [Number] = []
        for key in numbersCount.keys.sorted().reversed() {
            if let val = numbersCount[key] {
                if val >= 2 {
                    numbers.append(key)
                }
                count += val / 2
                if count >= 2 {
                    break
                }
            }
        }

        guard count >= 2 else {
            return []
        }

        var result = cards.filter { numbers.contains($0.number) }

        var candidates = cards.filter { !numbers.contains($0.number) }.sorted().reversed()

        if let first = candidates.first {
            result.append(first)
        }

        return result
    }
}

// MARK: - PairBuilder

class PairBuilder: RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
        }

        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        var count = 0
        var numbers: [Number] = []
        for key in numbersCount.keys.sorted().reversed() {
            if let val = numbersCount[key] {
                if val >= 2 {
                    numbers.append(key)
                }
                count += val / 2
                if count >= 1 {
                    break
                }
            }
        }

        guard count >= 1 else {
            return []
        }

        var result = cards.filter { numbers.contains($0.number) }

        var candidates = Array(cards.filter { !numbers.contains($0.number) }.sorted().reversed())

        let leftCount = Card.HandCardsNumber - result.count

        result.append(contentsOf: candidates[0 ..< leftCount])

        return result
    }
}

// MARK: - HighCardBuilder

class HighCardBuilder: RankBuilder {
    func build(privateCards: [Card], publicCards: [Card]) -> [Card] {
        let cards = privateCards + publicCards
        guard cards.count == Card.AllCardsTotalNumber else {
            return []
        }

        let result = Array(cards.sorted().reversed()[0 ..< Card.HandCardsNumber])

        return result
    }
}
