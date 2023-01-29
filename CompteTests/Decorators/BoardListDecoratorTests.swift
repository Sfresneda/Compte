//
//  BoardListDecoratorTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import XCTest
@testable import Compte

final class BoardListDecoratorTests: XCTestCase {
    var sut: BoardListDecoratorMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BoardListDecoratorMock()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_navigationItems_with_default_implementation_should_succeed() {
        // given
        let defaultBLD = DefaultBoardListDecorator()

        // when
        let nbtc = sut.navigationBarTintColor
        let nbta = sut.navigationBarTitleAttributes
        let nblta = sut.navigationBarLargeTitleAttributes
        let nbtdm = sut.navigationBarTitleDisplayMode
        let nbt = sut.navigationBarTitle
        let nbac = sut.navigationBarAccentColor

        let vbc = sut.viewBackgroundColor

        // then
        XCTAssertEqual(nbtc, defaultBLD.navigationBarTintColor)
        XCTAssertEqual(nbta.keys, defaultBLD.navigationBarTitleAttributes.keys)
        XCTAssertEqual(nblta.keys, defaultBLD.navigationBarLargeTitleAttributes.keys)
        XCTAssertEqual(nbtdm, defaultBLD.navigationBarTitleDisplayMode)
        XCTAssertEqual(nbt, defaultBLD.navigationBarTitle)
        XCTAssertEqual(nbac, defaultBLD.navigationBarAccentColor)

        XCTAssertEqual(vbc, defaultBLD.viewBackgroundColor)
    }
    func test_tapview_with_custom_implementation_should_fail() {
        // given
        let defaultBLD = DefaultBoardListDecorator()

        // when
        let tvtt = sut.tapViewTextTitle
        let tvf = sut.tapViewFont
        let tvbc = sut.tapViewBackgroundColor
        let tvsr = sut.tapViewShadowRadius
        let tvp = sut.tapViewPadding

        // then
        XCTAssertNotEqual(tvtt, defaultBLD.tapViewTextTitle)
        XCTAssertNotEqual(tvf, defaultBLD.tapViewFont)
        XCTAssertNotEqual(tvbc, defaultBLD.tapViewBackgroundColor)
        XCTAssertNotEqual(tvsr, defaultBLD.tapViewShadowRadius)
        XCTAssertNotEqual(tvp, defaultBLD.tapViewPadding)
    }
}
