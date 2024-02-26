//
//  NumberTests.swift
//  FlushWatch Watch AppTests
//
//  Created by Kai Chen on 12/15/23.
//

import XCTest
@testable import Flush

final class NumberTests: XCTestCase {
    func testSomeNumbers() {
        XCTAssertTrue(Number.two < Number.three, "2 < 3")
        XCTAssertTrue(Number.two < Number.four, "2 < 4")
        XCTAssertTrue(Number.four < Number.ace, "4 < A")
        XCTAssertTrue(Number.ace > Number.four, "A > 4")
        XCTAssertTrue(Number.queen < Number.king, "Q < K")
        XCTAssertTrue(Number.king > Number.queen, "K > Q")
        XCTAssertTrue(Number.ace == Number.ace, "A == A")
        XCTAssertTrue(Number.king == Number.king, "K == K")
        XCTAssertEqual(Number.ace, Number.ace, "A == A")
        XCTAssertTrue(Number.ace > Number.king, "Ace > King")
        XCTAssertTrue(Number.king < Number.ace, "King < Ace")
    }
}
