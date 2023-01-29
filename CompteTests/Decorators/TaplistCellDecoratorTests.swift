//
//  TaplistCellDecoratorTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import XCTest
@testable import Compte

final class TaplistCellDecoratorTests: XCTestCase {
    var sut: TapListCellDecoratorMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TapListCellDecoratorMock()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_with_default_implementation_should_succeed() {
        // given
        let defaultTLCD = DefaultTapListCellDecorator()

        // when
        let tnf = sut.tapNumberFont
        let tnc = sut.tapNumberColor
        let tnp = sut.tapNumberPadding
        let tds = sut.topDateStyle
        let tdf = sut.topDateFont

        // then
        XCTAssertEqual(tnf, defaultTLCD.tapNumberFont)
        XCTAssertEqual(tnc, defaultTLCD.tapNumberColor)
        XCTAssertEqual(tnp, defaultTLCD.tapNumberPadding)
        XCTAssertEqual(tds, defaultTLCD.topDateStyle)
        XCTAssertEqual(tdf, defaultTLCD.topDateFont)
    }
    func test_with_default_implementation_should_fail() {
        // given
        let defaultTLCD = DefaultTapListCellDecorator()

        // when
        let sds = sut.secondaryDateStyle
        let sdf = sut.secondaryDateFont
        let sdfc = sut.secondaryDateFontColor

        // then
        XCTAssertNotEqual(sds, defaultTLCD.secondaryDateStyle)
        XCTAssertNotEqual(sdf, defaultTLCD.secondaryDateFont)
        XCTAssertNotEqual(sdfc, defaultTLCD.secondaryDateFontColor)
    }
}
