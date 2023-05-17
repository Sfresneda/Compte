//
//  BoardListVModelTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 28/12/22.
//

import XCTest
@testable import Compte
import Combine

// MARK: - BoardListVModelTests
final class BoardListVModelTests: XCTestCase {
    // MARK: Vars
    var sut: BoardListVModel<PersistenceManager>!
    var cancellable: AnyCancellable?
    private let handleNavbarButtonTimeOut: TimeInterval = 0.02
    private let addTimeOut: TimeInterval = 0.02
    private let updateTimeOut: TimeInterval = 0.02
    private let deleteTimeOut: TimeInterval = 0.02

    // MARK: Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        let persistenceManager = PersistenceManager(dataStore: DataStoreMock())
        sut = BoardListVModel(dataManager: persistenceManager)
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        cancellable = nil
    }
}
// MARK: - renameViewInvocationAction
extension BoardListVModelTests {
    func test_renameViewInvocationAction_new_action_isRenameViewPresented_should_succeed() {
        // given
        let action = RenameViewPresentingAction.new

        // when
        sut.renameViewInvocationAction(action)

        // then
        XCTAssertTrue(sut.isRenameViewPresented)
        XCTAssertFalse(sut.isAnObjectToRename)
        XCTAssertNil(sut.objectToRename)
    }
    func test_renameViewInvocationAction_edit_action_isRenameViewPresented_should_succeed() {
        // given
        let object = CompteObject.defaultImplementation
        let action = RenameViewPresentingAction.edit(object)

        // when
        sut.renameViewInvocationAction(action)

        // then
        XCTAssertTrue(sut.isRenameViewPresented)
        XCTAssertTrue(sut.isAnObjectToRename)
        XCTAssertNotNil(sut.objectToRename)
    }
    func test_renameViewInvocationAction_done_action_isRenameViewPresented_should_succeed() {
        // given
        let action1 = RenameViewPresentingAction.new
        let action2 = RenameViewPresentingAction.done

        // when
        sut.renameViewInvocationAction(action1)
        sut.renameViewInvocationAction(action2)

        // then
        XCTAssertFalse(sut.isRenameViewPresented)
        XCTAssertFalse(sut.isAnObjectToRename)
        XCTAssertNil(sut.objectToRename)
    }
}
// MARK: - renameViewSubmitAction
extension BoardListVModelTests {
    func test_renameViewSubmitAction_add_action_isRenameViewPresented_should_succeed() {
        // given
        let name = "\(name)"
        let action = RenameViewSubmitAction.add(name)

        // when
        sut.renameViewSubmitAction(action)

        // then
        XCTAssertFalse(sut.isRenameViewPresented)
        XCTAssertFalse(sut.isAnObjectToRename)
        XCTAssertNil(sut.objectToRename)
    }
    func test_renameViewSubmitAction_update_action_isRenameViewPresented_should_succeed() {
        // given
        let name = "\(name)"
        let action = RenameViewSubmitAction.update(name)

        // when
        sut.renameViewSubmitAction(action)

        // then
        XCTAssertFalse(sut.isRenameViewPresented)
        XCTAssertFalse(sut.isAnObjectToRename)
        XCTAssertNil(sut.objectToRename)
    }
}
// MARK: - handleNavbarButton
extension BoardListVModelTests {
    func test_handleNavbarButton_new_action_should_succeed() {
        // given
        let expectedNumberOfItems = 1
        let action = NavbarButton.new
        let expectation = XCTestExpectation(description: "add action change items collection")

        // when
        XCTAssertTrue(sut.items.isEmpty)
        sut.handleNavbarButton(action)
        cancellable = sut
            .objectWillChange
            .sink { _ in
                expectation.fulfill()
            }

        // then
        wait(for: [expectation], timeout: handleNavbarButtonTimeOut)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
    }
    func test_handleNavbarButton_new_action_twice_should_succeed() {
        // given
        let expectedNumberOfItems = 2
        let action = NavbarButton.new
        let expectation = XCTestExpectation(description: "add action change items collection")
        expectation.expectedFulfillmentCount = 2

        // when
        XCTAssertTrue(sut.items.isEmpty)
        sut.handleNavbarButton(action)
        sut.handleNavbarButton(action)

        cancellable = sut
            .objectWillChange
            .sink { _ in
                expectation.fulfill()
            }

        // then
        wait(for: [expectation], timeout: handleNavbarButtonTimeOut)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
    }
}
// MARK: - add
extension BoardListVModelTests {
    func test_add_new_item_with_specified_name_should_succeed() {
        // given
        let expectedNumberOfItems = 1
        let name = "\(name)"
        let expectation = XCTestExpectation(description: "add action change items collection")

        // when
        XCTAssertTrue(sut.items.isEmpty)
        sut.add(with: name)
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })

        // then
        wait(for: [expectation], timeout: addTimeOut)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
        let item = sut.items.first
        XCTAssertNotNil(item)
        XCTAssertEqual(item?.name, name)
    }
    func test_add_new_item_without_specified_name_should_succeed() {
        // given
        let expectedNumberOfItems = 1
        let expectation = XCTestExpectation(description: "add action change items collection")

        // when
        XCTAssertTrue(sut.items.isEmpty)
        sut.add()
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })

        // then
        wait(for: [expectation], timeout: addTimeOut)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
        let item = sut.items.first
        XCTAssertNotNil(item)
        XCTAssertNotEqual(item?.name, name)
    }
}
// MARK: - updateName
extension BoardListVModelTests {
    func test_updateName_add_and_update_items_name_should_succeed() {
        // given
        let name = "\(name)"
        let newName = "\(name)-update"
        let addExpectation = XCTestExpectation(description: "add action change items collection")
        let updateExpectation = XCTestExpectation(description: "update action change items collection")

        // when
        XCTAssertTrue(sut.items.isEmpty)
        sut.add(with: name)

        cancellable = sut
            .objectWillChange
            .sink { _ in
                addExpectation.fulfill()

                let item = self.sut.items.first
                if let item, name == item.name {
                    self.sut.objectToRename = item
                    self.sut.updateName(newName)
                }
                if newName == item?.name {
                    updateExpectation.fulfill()
                }
            }

        // then
        wait(for: [addExpectation, updateExpectation], timeout: updateTimeOut, enforceOrder: true)
        XCTAssertFalse(sut.items.isEmpty)
        let item = sut.items.first
        XCTAssertNotNil(item)
        XCTAssertEqual(item?.name, newName)
    }
    func test_updateName_add_and_update_items_name_trimmed_should_succeed() {
        // given
        let name = "\(name)"
        let newName = "   \(name)-update   "
        let newNameTrimmed = newName.trimmingCharacters(in: .whitespacesAndNewlines)
        let addExpectation = XCTestExpectation(description: "add action change items collection")
        let updateExpectation = XCTestExpectation(description: "update action change items collection")

        // when
        XCTAssertTrue(sut.items.isEmpty)
        sut.add(with: name)

        cancellable = sut
            .objectWillChange
            .sink { _ in
                addExpectation.fulfill()

                let item = self.sut.items.first
                if let item, name == item.name {
                    self.sut.objectToRename = item
                    self.sut.updateName(newName)
                }
                if newNameTrimmed == item?.name {
                    updateExpectation.fulfill()
                }
            }

        // then
        wait(for: [addExpectation, updateExpectation], timeout: updateTimeOut, enforceOrder: true)
        XCTAssertFalse(sut.items.isEmpty)
        let item = sut.items.first
        XCTAssertNotNil(item)
        XCTAssertEqual(item?.name, newNameTrimmed)
    }

    func test_updateName_add_and_update_items_name_without_set_objectToRename_should_fail() {
        // given
        let name = "\(name)"
        let newName = "\(name)-update"
        let addExpectation = XCTestExpectation(description: "add action change items collection")
        let updateExpectation = XCTestExpectation(description: "update action will never be fulfilled")
        updateExpectation.isInverted = true

        // when
        XCTAssertTrue(sut.items.isEmpty)
        sut.add(with: name)

        cancellable = sut
            .objectWillChange
            .sink { _ in
                addExpectation.fulfill()

                let objectName = self.sut.items.first?.name
                if name == objectName {
                    self.sut.updateName(newName)
                }
                if newName == objectName {
                    updateExpectation.assertForOverFulfill.toggle()
                }
            }

        // then
        wait(for: [addExpectation, updateExpectation], timeout: updateTimeOut, enforceOrder: true)
        XCTAssertFalse(sut.items.isEmpty)
        let item = sut.items.first
        XCTAssertNotNil(item)
        XCTAssertEqual(item?.name, name)
    }
}
// MARK: - delete
extension BoardListVModelTests {
    func test_delete_remove_an_known_item_should_succeed() {
        // given
        let expectedNumberOfItems = 1
        let addExpectation = XCTestExpectation(description: "add action change items collection to 1")
        let deleteExpectation = XCTestExpectation(description: "delete action change items collection to zero")
        var isDeleteActionLaunched: Bool = false

        // when
        sut.add()
        sut.add()

        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                addExpectation.fulfill()

                let itemIdentifier = self.sut.firstItemIdentifier

                if isDeleteActionLaunched {
                    deleteExpectation.fulfill()
                }

                if !isDeleteActionLaunched, let itemIdentifier {
                    isDeleteActionLaunched.toggle()
                    self.sut.delete(itemIdentifier)
                }
            })

        // then
        wait(for: [addExpectation, deleteExpectation], timeout: deleteTimeOut, enforceOrder: true)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
    }
    func test_delete_remove_an_unknown_item_should_fail() {
        // given
        let expectedNumberOfItems = 2
        let addExpectation = XCTestExpectation(description: "add action change items collection to 1")
        let deleteExpectation = XCTestExpectation(description: "delete action will never be fulfilled")
        deleteExpectation.isInverted = true
        var isDeleteActionLaunched: Bool = false
        var lastItems: [CompteObject] = []

        // when
        sut.add()
        sut.add()

        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                addExpectation.fulfill()

                if isDeleteActionLaunched,
                    lastItems.count > self.sut.items.count {
                    deleteExpectation.assertForOverFulfill.toggle()
                }

                lastItems = self.sut.items

                if nil != self.sut.firstItemIdentifier,
                   !isDeleteActionLaunched {
                    isDeleteActionLaunched.toggle()
                    self.sut.delete(UUID())
                }
            })

        // then
        wait(for: [addExpectation, deleteExpectation], timeout: deleteTimeOut, enforceOrder: true)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
    }
}
