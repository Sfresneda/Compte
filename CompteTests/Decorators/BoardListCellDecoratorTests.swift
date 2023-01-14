//
//  BoardListCellDecoratorTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import XCTest
@testable import Compte

final class BoardListCellDecoratorTests: XCTestCase {
    var sut: BoardListCellDecoratorMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BoardListCellDecoratorMock()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_tapsIndicator_with_default_implementation_should_succeed() {
        // given
        let defaultBLCD = DefaultBoardListCellDecorator()

        // when
        let tif = sut.tapsIndicatorFont
        let tifc = sut.tapsIndicatorForegroundColor
        let tita = sut.tapsIndicatorTextAligment
        let timw = sut.tapsIndicatorMaxWidth
        let timh = sut.tapsIndicatorMaxHeight
        let tia = sut.tapsIndicatorTextAligment
        let tp = sut.tapsIndicatorPadding
        let tibc = sut.tapsIndicatorBackgroundColor
        let ticr = sut.tapsIndicatorCornerRadious

        // then
        XCTAssertEqual(tif, defaultBLCD.tapsIndicatorFont)
        XCTAssertEqual(tifc, defaultBLCD.tapsIndicatorForegroundColor)
        XCTAssertEqual(tita, defaultBLCD.tapsIndicatorTextAligment)
        XCTAssertEqual(timw, defaultBLCD.tapsIndicatorMaxWidth)
        XCTAssertEqual(timh, defaultBLCD.tapsIndicatorMaxHeight)
        XCTAssertEqual(tia, defaultBLCD.tapsIndicatorTextAligment)
        XCTAssertEqual(tp, defaultBLCD.tapsIndicatorPadding)
        XCTAssertEqual(tibc, defaultBLCD.tapsIndicatorBackgroundColor)
        XCTAssertEqual(ticr, defaultBLCD.tapsIndicatorCornerRadious)
    }

    func test_board_with_custom_implementation_should_fail() {
        // given
        let defaultBLCD = DefaultBoardListCellDecorator()

        // when
        let btf = sut.boardTitleFont
        let bfc = sut.boardForegroundColor
        let btll = sut.boardTitleLinesLimit

        // then
        XCTAssertNotEqual(btf, defaultBLCD.boardTitleFont)
        XCTAssertNotEqual(bfc, defaultBLCD.boardForegroundColor)
        XCTAssertNotEqual(btll, defaultBLCD.boardTitleLinesLimit)
    }

    func test_lastModification_with_default_implementation_should_succeed() {
        // given
        let defaultBLCD = DefaultBoardListCellDecorator()

        // when
        let lmf = sut.lastModificationFormat
        let lmfnt = sut.lastModificationFont
        let lmfc = sut.lastModificationForegroundColor

        // then
        XCTAssertEqual(lmf, defaultBLCD.lastModificationFormat)
        XCTAssertEqual(lmfnt, defaultBLCD.lastModificationFont)
        XCTAssertEqual(lmfc, defaultBLCD.lastModificationForegroundColor)
    }

}
