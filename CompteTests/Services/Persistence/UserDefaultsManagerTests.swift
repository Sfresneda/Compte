//
//  UserDefaultsManagerTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 6/5/23.
//

import XCTest
@testable import Compte

final class UserDefaultsManagerTests: XCTestCase {
    var sut: UserDefaultsManager!

    override func setUpWithError() throws {
        sut = UserDefaultsManager.shared as? UserDefaultsManager
        sut.purgue()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_toogle_to_true_focusmode() {
        // given
        let expectedValue = true

        // when
        sut.toogleFocusMode()

        // then
        XCTAssertEqual(expectedValue, sut.getFocusMode())
    }

    func test_toogle_to_false_focusmode() {
        // given
        let expectedValue = false

        // when
        sut.toogleFocusMode()
        XCTAssertTrue(sut.getFocusMode())
        sut.toogleFocusMode()

        // then
        XCTAssertEqual(expectedValue, sut.getFocusMode())
    }

    func test_default_value_must_be_false_focusmode() {
        // given
        let expectedValue = false

        // when
        let result = sut.getFocusMode()

        // then
        XCTAssertEqual(expectedValue, result)
    }
}
