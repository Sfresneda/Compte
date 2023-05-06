//
//  SettingsVModelTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 6/5/23.
//

import XCTest
@testable import Compte

final class SettingsVModelTests: XCTestCase {
    var sut: SettingsVModel!
    let spy = UserDefaultsSpy()

    override func setUpWithError() throws {
        sut = SettingsVModel(persistenceManager: spy)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_appVersionNumberText_must_return_correct_string() {
        // given
        let expectedValue = "V\(Bundle.main.releaseVersionNumber!)(\(Bundle.main.buildVersionNumber!))"

        // when
        let result = sut.appVersionNumberText

        // then
        XCTAssertEqual(expectedValue, result)
    }

    func test_setFocusMode_must_toogle_toogleFocusModeSpy_var() {
        // given
        let expectedValue = true

        // when
        sut.toggleFocusMode()

        // then
        XCTAssertEqual(expectedValue, spy.toogleFocusModeSpy)
    }
}
