//
//  BoardScrollDecoratorTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import XCTest
@testable import Compte

final class BoardScrollDecoratorTests: XCTestCase {
    var sut: BoardScrollDecoratorMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BoardScrollDecoratorMock()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_swipe_with_default_implementation_should_succeed() {
        // given
        let defaultBSD = DefaultBoardScrollDecorator()

        // when
        let sdal = sut.swipeDeleteActionLabel
        let sdt = sut.swipeDeleteTint
        let sral = sut.swipeRenameActionLabel
        let srt = sut.swipeRenameTint

        // then
        XCTAssertEqual(sdal, defaultBSD.swipeDeleteActionLabel)
        XCTAssertEqual(sdt, defaultBSD.swipeDeleteTint)
        XCTAssertEqual(sral, defaultBSD.swipeRenameActionLabel)
        XCTAssertEqual(srt, defaultBSD.swipeRenameTint)
    }
    func test_other_with_custom_implementation_should_fail() {
        // given
        let defaultBSD = DefaultBoardScrollDecorator()

        // when
        let lri = sut.listRowInsets
        let lrb = sut.listRowBackground
        let bc = sut.backgroundColor

        // then
        XCTAssertNotEqual(lri, defaultBSD.listRowInsets)
        XCTAssertNotEqual(lrb, defaultBSD.listRowBackground)
        XCTAssertNotEqual(bc, defaultBSD.backgroundColor)
    }
}
