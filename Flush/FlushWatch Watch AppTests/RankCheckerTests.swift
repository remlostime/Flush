//
//  RankCheckerTests.swift
//  FlushWatch Watch AppTests
//
//  Created by Kai Chen on 12/15/23.
//

import XCTest
@testable import FlushWatch_Watch_App

final class RankCheckerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRoyalFlushChcker() {
        let privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        let publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let royalFlushChecker = RoyalFlushChecker()
        XCTAssertTrue(royalFlushChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K A should be royal flush")

        let publicCards2 = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 3),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertFalse(royalFlushChecker.isValid(privateCards: privateCards, publicCards: publicCards2), "Should not be royal flush")

        let privateCards2 = [
            Card(kind: .club, number: 10),
            Card(kind: .heart, number: 11)
        ]

        XCTAssertFalse(royalFlushChecker.isValid(privateCards: privateCards2, publicCards: publicCards), "Should not be royal flush")

        let clubPrivateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 9)
        ]

        let clubPublicCards = [
            Card(kind: .club, number: 12),
            Card(kind: .club, number: 13),
            Card(kind: .club, number: 10),
            Card(kind: .club, number: 1),
            Card(kind: .club, number: 11)
        ]

        XCTAssertTrue(royalFlushChecker.isValid(privateCards: clubPrivateCards, publicCards: clubPublicCards), "Club 10 J Q K A should be royal flush")
    }

    func testStraightFlushChecker() {
        let privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        let publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let straightFlushChecker = StraightFlushChecker()
        XCTAssertTrue(straightFlushChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K A should be straight flush")

        let publicCards2 = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 3),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertFalse(straightFlushChecker.isValid(privateCards: privateCards, publicCards: publicCards2), "Should not be straight flush")

        let privateCards2 = [
            Card(kind: .club, number: 10),
            Card(kind: .heart, number: 11)
        ]

        XCTAssertFalse(straightFlushChecker.isValid(privateCards: privateCards2, publicCards: publicCards), "Should not be straight flush")

        let clubPrivateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 9)
        ]

        let clubPublicCards = [
            Card(kind: .club, number: 12),
            Card(kind: .club, number: 13),
            Card(kind: .club, number: 10),
            Card(kind: .club, number: 1),
            Card(kind: .club, number: 11)
        ]

        XCTAssertTrue(straightFlushChecker.isValid(privateCards: clubPrivateCards, publicCards: clubPublicCards), "Club 10 J Q K A should be straight flush")

        let smallPrivateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .heart, number: .two)
        ]

        let smallPublicCards = [
            Card(kind: .heart, number: .three),
            Card(kind: .heart, number: .four),
            Card(kind: .heart, number: .five),
            Card(kind: .heart, number: .ten),
            Card(kind: .heart, number: .jack)
        ]

        XCTAssertTrue(straightFlushChecker.isValid(privateCards: clubPrivateCards, publicCards: clubPublicCards), "Heart A 2 3 4 5 should be straight flush")

        let smallPrivateCards1 = [
            Card(kind: .heart, number: .six),
            Card(kind: .heart, number: .two)
        ]

        let smallPublicCards1 = [
            Card(kind: .heart, number: .three),
            Card(kind: .heart, number: .four),
            Card(kind: .heart, number: .five),
            Card(kind: .heart, number: .ten),
            Card(kind: .heart, number: .jack)
        ]

        XCTAssertTrue(straightFlushChecker.isValid(privateCards: clubPrivateCards, publicCards: clubPublicCards), "Heart 2 3 4 5 6 should be straight flush")
    }

    func testFourKindChecker() {
        var privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        var publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let fourKindChecker = FourKindChecker()
        XCTAssertFalse(fourKindChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K A should not be four kind")

        privateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .ace)
        ]

        publicCards = [
            Card(kind: .diamond, number: .ace),
            Card(kind: .club, number: .ace),
            Card(kind: .heart, number: .eight),
            Card(kind: .club, number: .king),
            Card(kind: .spade, number: .ten)
        ]

        XCTAssertTrue(fourKindChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Four kinds of ace")

        privateCards = [
            Card(kind: .heart, number: .king),
            Card(kind: .spade, number: .king)
        ]

        publicCards = [
            Card(kind: .diamond, number: .king),
            Card(kind: .club, number: .king),
            Card(kind: .heart, number: .eight),
            Card(kind: .club, number: .nine),
            Card(kind: .spade, number: .ten)
        ]

        XCTAssertTrue(fourKindChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Four kinds of king")

        privateCards = [
            Card(kind: .heart, number: .king),
            Card(kind: .spade, number: .king)
        ]

        publicCards = [
            Card(kind: .diamond, number: .queen),
            Card(kind: .club, number: .queen),
            Card(kind: .heart, number: .eight),
            Card(kind: .club, number: .queen),
            Card(kind: .spade, number: .queen)
        ]

        XCTAssertTrue(fourKindChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Four kinds of queen")
    }

    func testFullHouseChecker() {
        var privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        var publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let fullHouseChecker = FullHouseChecker()
        XCTAssertFalse(fullHouseChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K A should not be full house")

        privateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .ace)
        ]

        publicCards = [
            Card(kind: .diamond, number: .ace),
            Card(kind: .club, number: .ace),
            Card(kind: .heart, number: .eight),
            Card(kind: .club, number: .king),
            Card(kind: .spade, number: .ten)
        ]

        XCTAssertFalse(fullHouseChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Not full house")

        privateCards = [
            Card(kind: .heart, number: .king),
            Card(kind: .spade, number: .king)
        ]

        publicCards = [
            Card(kind: .diamond, number: .king),
            Card(kind: .club, number: .king),
            Card(kind: .heart, number: .eight),
            Card(kind: .club, number: .nine),
            Card(kind: .spade, number: .ten)
        ]

        XCTAssertFalse(fullHouseChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Not full house")

        privateCards = [
            Card(kind: .heart, number: .king),
            Card(kind: .spade, number: .eight)
        ]

        publicCards = [
            Card(kind: .diamond, number: .queen),
            Card(kind: .club, number: .queen),
            Card(kind: .heart, number: .eight),
            Card(kind: .heart, number: .queen),
            Card(kind: .spade, number: .queen)
        ]

        XCTAssertFalse(fullHouseChecker.isValid(privateCards: privateCards, publicCards: publicCards), "QQQ 88 should be full house")

        privateCards = [
            Card(kind: .heart, number: .king),
            Card(kind: .spade, number: .eight)
        ]

        publicCards = [
            Card(kind: .diamond, number: .ace),
            Card(kind: .club, number: .ace),
            Card(kind: .heart, number: .eight),
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .queen)
        ]

        XCTAssertTrue(fullHouseChecker.isValid(privateCards: privateCards, publicCards: publicCards), "AAA 88 should be full house")
    }

    func testFlushChecker() {
        var privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        var publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let flushChecker = FlushChecker()
        XCTAssertTrue(flushChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K A should be flush")

        privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 5),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(flushChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K 5 should be flush")

        privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertFalse(flushChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K should not be flush")
    }

    func testStraightChecker() {
        var privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        var publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let straightChecker = StraightChecker()
        XCTAssertTrue(straightChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K A should be flush")

        publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 3),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(straightChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K, Club A should be straight")

        privateCards = [
            Card(kind: .club, number: 10),
            Card(kind: .heart, number: 11)
        ]

        publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(straightChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Club 10, Heart J Q K A should be straight")

        let clubPrivateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 9)
        ]

        let clubPublicCards = [
            Card(kind: .club, number: 12),
            Card(kind: .club, number: 13),
            Card(kind: .club, number: 10),
            Card(kind: .club, number: 1),
            Card(kind: .club, number: 11)
        ]

        XCTAssertTrue(straightChecker.isValid(privateCards: clubPrivateCards, publicCards: clubPublicCards), "Club 10 J Q K A should be straight")

        let smallPrivateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .heart, number: .two)
        ]

        let smallPublicCards = [
            Card(kind: .heart, number: .three),
            Card(kind: .heart, number: .four),
            Card(kind: .heart, number: .five),
            Card(kind: .heart, number: .ten),
            Card(kind: .heart, number: .jack)
        ]

        XCTAssertTrue(straightChecker.isValid(privateCards: smallPrivateCards, publicCards: smallPublicCards), "Heart A 2 3 4 5 should be straight")

        let smallPrivateCards1 = [
            Card(kind: .heart, number: .six),
            Card(kind: .heart, number: .two)
        ]

        let smallPublicCards1 = [
            Card(kind: .heart, number: .three),
            Card(kind: .heart, number: .four),
            Card(kind: .heart, number: .five),
            Card(kind: .heart, number: .ten),
            Card(kind: .heart, number: .jack)
        ]

        XCTAssertTrue(straightChecker.isValid(privateCards: smallPrivateCards1, publicCards: smallPublicCards1), "Heart 2 3 4 5 6 should be straight")

        let smallPrivateCards2 = [
            Card(kind: .club, number: .six),
            Card(kind: .heart, number: .two)
        ]

        let smallPublicCards2 = [
            Card(kind: .heart, number: .three),
            Card(kind: .spade, number: .four),
            Card(kind: .diamond, number: .five),
            Card(kind: .heart, number: .ten),
            Card(kind: .heart, number: .jack)
        ]

        XCTAssertTrue(straightChecker.isValid(privateCards: smallPrivateCards2, publicCards: smallPublicCards2), "Mix 2 3 4 5 6 should be straight")
    }

    func testThreeKindChecker() {
        var privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        var publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let threeKindChecker = ThreeKindChecker()
        XCTAssertFalse(threeKindChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart 10 J Q K A should not be three kind")

        privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .spade, number: 10)
        ]

        publicCards = [
            Card(kind: .diamond, number: 10),
            Card(kind: .heart, number: 13),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(threeKindChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Mix 10 should be three kind")

        privateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .ace)
        ]

        publicCards = [
            Card(kind: .diamond, number: .ace),
            Card(kind: .club, number: .ace),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: .eight),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(threeKindChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Mix A should be three kind")
    }

    func testTwoPairsChecker() {
        var privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        var publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let twoPairsChecker = TwoPairsChecker()
        XCTAssertFalse(twoPairsChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart A, Club should not be two pairs")

        privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .spade, number: 10)
        ]

        publicCards = [
            Card(kind: .diamond, number: 10),
            Card(kind: .heart, number: 13),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertFalse(twoPairsChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Mix 10 should not be two pairs")

        privateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .ace)
        ]

        publicCards = [
            Card(kind: .diamond, number: .ace),
            Card(kind: .club, number: .ace),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: .eight),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(twoPairsChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Mix A should be two pairs")

        privateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .ace)
        ]

        publicCards = [
            Card(kind: .diamond, number: .eight),
            Card(kind: .spade, number: .eight),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: .eight),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(twoPairsChecker.isValid(privateCards: privateCards, publicCards: publicCards), "1 pair A, 1 pair 8 should be two pairs")
    }

    func testPairChecker() {
        var privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        var publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let pairChecker = PairChecker()
        XCTAssertTrue(pairChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart A, Club A should be pair.")

        privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .spade, number: 10)
        ]

        publicCards = [
            Card(kind: .diamond, number: 10),
            Card(kind: .heart, number: 13),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(pairChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Mix 10 should be pairs")

        privateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .ace)
        ]

        publicCards = [
            Card(kind: .diamond, number: .ace),
            Card(kind: .club, number: .ace),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: .eight),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(pairChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Mix A should be pairs")

        privateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .ace)
        ]

        publicCards = [
            Card(kind: .diamond, number: .eight),
            Card(kind: .spade, number: .eight),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: .eight),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(pairChecker.isValid(privateCards: privateCards, publicCards: publicCards), "1 pair A, 1 pair 8 should be pairs")

        privateCards = [
            Card(kind: .heart, number: .ace),
            Card(kind: .spade, number: .ten)
        ]

        publicCards = [
            Card(kind: .diamond, number: .eight),
            Card(kind: .spade, number: .six),
            Card(kind: .club, number: .five),
            Card(kind: .club, number: .four),
            Card(kind: .spade, number: .two)
        ]

        XCTAssertFalse(pairChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Should not be pair")
    }

    func testHighCardChecker() {
        var privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .heart, number: 11)
        ]

        var publicCards = [
            Card(kind: .heart, number: 12),
            Card(kind: .heart, number: 13),
            Card(kind: .heart, number: 1),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        let highCardChecker = HighCardChecker()
        XCTAssertTrue(highCardChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart A should be high card.")

        privateCards = [
            Card(kind: .heart, number: 10),
            Card(kind: .spade, number: 10)
        ]

        publicCards = [
            Card(kind: .diamond, number: 10),
            Card(kind: .heart, number: 13),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: 1),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(highCardChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Heart K should be high card")

        privateCards = [
            Card(kind: .heart, number: .jack),
            Card(kind: .spade, number: .ten)
        ]

        publicCards = [
            Card(kind: .diamond, number: .ten),
            Card(kind: .club, number: .ten),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: .eight),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(highCardChecker.isValid(privateCards: privateCards, publicCards: publicCards), "J should be high card")

        privateCards = [
            Card(kind: .heart, number: .ten),
            Card(kind: .spade, number: .ten)
        ]

        publicCards = [
            Card(kind: .diamond, number: .eight),
            Card(kind: .spade, number: .six),
            Card(kind: .club, number: .five),
            Card(kind: .club, number: .four),
            Card(kind: .spade, number: .two)
        ]

        XCTAssertFalse(highCardChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Should not have high cards.")

        privateCards = [
            Card(kind: .heart, number: .queen),
            Card(kind: .spade, number: .ten)
        ]

        publicCards = [
            Card(kind: .diamond, number: .ten),
            Card(kind: .club, number: .ten),
            Card(kind: .club, number: 5),
            Card(kind: .club, number: .eight),
            Card(kind: .spade, number: 2)
        ]

        XCTAssertTrue(highCardChecker.isValid(privateCards: privateCards, publicCards: publicCards), "Q is high cards.")
    }
}
