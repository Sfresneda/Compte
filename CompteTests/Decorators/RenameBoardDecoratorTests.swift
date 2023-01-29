//
//  RenameBoardDecoratorTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import XCTest
@testable import Compte

final class RenameBoardDecoratorTests: XCTestCase {
    var sut: RenameBoardDecoratorMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RenameBoardDecoratorMock()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_limitChars_with_default_implementation_should_succeed() {
        // given
        let defaultRBD = DefaultRenameBoardDecorator()

        // when
        let lc = sut.limitChars
        let lct = sut.limitCharsText
        let lcmw = sut.limitCharsMaxWidth
        let lca = sut.limitCharsAligment
        let lcfc = sut.limitCharsForegroundColor
        let lcf = sut.limitCharsFont

        // then
        XCTAssertEqual(lc, defaultRBD.limitChars)
        XCTAssertEqual(lct, defaultRBD.limitCharsText)
        XCTAssertEqual(lcmw, defaultRBD.limitCharsMaxWidth)
        XCTAssertEqual(lca, defaultRBD.limitCharsAligment)
        XCTAssertEqual(lcfc, defaultRBD.limitCharsForegroundColor)
        XCTAssertEqual(lcf, defaultRBD.limitCharsFont)
    }

    func test_with_custom_implementation_should_fail() {
        // given
        let defaultRBD = DefaultRenameBoardDecorator()

        // when
        let bc = sut.viewBackgroundColor
        let tebc = sut.textEditorBackgroundColor
        let tecr = sut.textEditorCornerRadius
        let vcsr = sut.viewCornerShadowRadius
        let vmh = sut.viewMaxHeight
        let oc = sut.overlayColor
        let oaa = sut.onAppearAnimation
        let cbt = sut.cancelButtonText
        let cbtc = sut.cancelButtonTintColor
        let sbt = sut.submitButtonText
        let sbti = sut.submitButtonTintColor

        // then
        XCTAssertNotEqual(bc, defaultRBD.viewBackgroundColor)
        XCTAssertNotEqual(tebc, defaultRBD.textEditorBackgroundColor)
        XCTAssertNotEqual(tecr, defaultRBD.textEditorCornerRadius)
        XCTAssertNotEqual(vcsr, defaultRBD.viewCornerShadowRadius)
        XCTAssertNotEqual(vmh, defaultRBD.viewMaxHeight)
        XCTAssertNotEqual(oc, defaultRBD.overlayColor)
        XCTAssertNotEqual(oaa, defaultRBD.onAppearAnimation)
        XCTAssertNotEqual(cbt, defaultRBD.cancelButtonText)
        XCTAssertNotEqual(cbtc, defaultRBD.cancelButtonTintColor)
        XCTAssertNotEqual(sbt, defaultRBD.submitButtonText)
        XCTAssertNotEqual(sbti, defaultRBD.submitButtonTintColor)
    }

    func test_maxReach_with_default_implementation_should_succeed() {
        // given
        let isMaxReach = true
        let defaultRBD = DefaultRenameBoardDecorator()

        // when
        let maxColor = sut.limitCharsLabelColor(isMaxReach)
        let maxFont = sut.limitCharsLabelFont(isMaxReach)

        // then
        XCTAssertNotEqual(maxColor, defaultRBD.limitCharsLabelColor(!isMaxReach))
        XCTAssertNotEqual(maxFont, defaultRBD.limitCharsLabelFont(!isMaxReach))
        XCTAssertEqual(maxColor, defaultRBD.limitCharsLabelColor(isMaxReach))
        XCTAssertEqual(maxFont, defaultRBD.limitCharsLabelFont(isMaxReach))
    }
}
