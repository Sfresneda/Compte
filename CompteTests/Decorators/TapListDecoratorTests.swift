//
//  TapListDecoratorTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import XCTest
@testable import Compte

final class TapListDecoratorTests: XCTestCase {
    var sut: TapListDecoratorMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TapListDecoratorMock()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_with_default_implementation_should_succeed() {
        // given
        let defaulTLD = DefaultTapListDecorator()

        // when
        let vbc = sut.viewBackgroundColor
        let st = sut.sectionTitle
        let sfc = sut.sectionForegroundColor
        let stta = sut.scrollToTopAnimation
        let lrbc = sut.listRowBackgroundColor
        let tbf = sut.tapButtonFont
        let tbmw = sut.tapButtonMaxWidth
        let tbbc = sut.tapButtonBackgroundColor
        let cvp = sut.counterViewPadding
        let cvmh = sut.counterViewMaxHeight
        let tbc = sut.trashButtonColor

        // then
        XCTAssertEqual(vbc, defaulTLD.viewBackgroundColor)
        XCTAssertEqual(st, defaulTLD.sectionTitle)
        XCTAssertEqual(sfc, defaulTLD.sectionForegroundColor)
        XCTAssertEqual(stta, defaulTLD.scrollToTopAnimation)
        XCTAssertEqual(lrbc, defaulTLD.listRowBackgroundColor)
        XCTAssertEqual(tbf, defaulTLD.tapButtonFont)
        XCTAssertEqual(tbmw, defaulTLD.tapButtonMaxWidth)
        XCTAssertEqual(tbbc, defaulTLD.tapButtonBackgroundColor)
        XCTAssertEqual(cvp, defaulTLD.counterViewPadding)
        XCTAssertEqual(cvmh, defaulTLD.counterViewMaxHeight)
        XCTAssertEqual(tbc, defaulTLD.trashButtonColor)
    }
    func test_with_custom_implementation_should_succeed() {
        // given
        let defaulTLD = DefaultTapListDecorator()

        // when
        let stua = sut.slideToUnlockAnimation
        let stuin = sut.slideToUnlockImageName
        let stuif = sut.slideToUnlockImageFont
        let stup = sut.slideToUnlockPadding

        // then
        XCTAssertNotEqual(stua, defaulTLD.slideToUnlockAnimation)
        XCTAssertNotEqual(stuin, defaulTLD.slideToUnlockImageName)
        XCTAssertNotEqual(stuif, defaulTLD.slideToUnlockImageFont)
        XCTAssertNotEqual(stup, defaulTLD.slideToUnlockPadding)
    }
}
