//
//  TapListVModelTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 29/12/22.
//

import XCTest
@testable import Compte
import Combine

// MARK: - TapListVModelTests
final class TapListVModelTests: XCTestCase {
    // MARK: Vars
    var sut: TapListVModel<PersistenceManager>!
    var object: CompteObject!
    var cancellable: AnyCancellable?
    private let addTimeOut: TimeInterval = 0.02
    private let cleanTimeOut: TimeInterval = 0.02
    private let deleteTimeOut: TimeInterval = 0.02

    // MARK: Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        let persistenceManager = PersistenceManager(dataStore: DataStoreMock())
        object = CompteObject.defaultImplementation()
        sut = TapListVModel(modelObject: object,
                            dataManager: persistenceManager)
        persistenceManager.add(mapper: CompteMapper(object))
        persistenceManager.fetch(mapper: CompteMapper())
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        object = nil
        cancellable = nil
    }
}
// MARK: - add
extension TapListVModelTests {
    func test_add_insert_new_item_should_succeed() {
        // given
        let expectedNumberOfItems = 1
        let addExpectation = XCTestExpectation(description: "add increase items collection")

        // when
        sut.add()
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                addExpectation.fulfill()
            })

        // then
        wait(for: [addExpectation], timeout: addTimeOut)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
    }
    func test_add_insert_two_item_should_succeed() {
        // given
        let expectedNumberOfItems = 2
        let addExpectation = XCTestExpectation(description: "add increase items collection")

        // when
        sut.add()
        sut.add()
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                addExpectation.fulfill()
            })

        // then
        wait(for: [addExpectation], timeout: addTimeOut)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
    }
}
// MARK: - delete
extension TapListVModelTests {
    func test_delete_remove_item_should_succeed() {
        // given
        let deleteExpectation = XCTestExpectation(description: "delete decrease items collection")
        var deleteActionLaunched = false

        // when
        sut.add()
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                if deleteActionLaunched, self.sut.isItemsEmpty {
                    deleteExpectation.fulfill()
                }

                if let itemIdentifier = self.sut.firstItemIdentifier, !deleteActionLaunched {
                    deleteActionLaunched.toggle()
                    self.sut.delete(itemIdentifier)
                }
            })

        // then
        wait(for: [deleteExpectation], timeout: deleteTimeOut)
        XCTAssertTrue(sut.items.isEmpty)
    }
    func test_delete_remove_one_item_should_succeed() {
        // given
        let expectedNumberOfItems = 1
        let deleteExpectation = XCTestExpectation(description: "delete decrease items collection")
        var deleteActionLaunched = false

        // when
        sut.add()
        sut.add()
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                if deleteActionLaunched {
                    deleteExpectation.fulfill()
                }

                if let itemIdentifier = self.sut.firstItemIdentifier, !deleteActionLaunched {
                    deleteActionLaunched.toggle()
                    self.sut.delete(itemIdentifier)
                }
            })

        // then
        wait(for: [deleteExpectation], timeout: deleteTimeOut)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
    }
    func test_delete_remove_one_item_should_fail() {
        // given
        let expectedNumberOfItems = 2
        let deleteExpectation = XCTestExpectation(description: "delete decrease items collection")
        var deleteActionLaunched = false

        // when
        sut.add()
        sut.add()
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                if deleteActionLaunched {
                    deleteExpectation.fulfill()
                }

                if !self.sut.items.isEmpty, !deleteActionLaunched {
                    deleteActionLaunched.toggle()
                    self.sut.delete(UUID())
                }
            })

        // then
        wait(for: [deleteExpectation], timeout: deleteTimeOut)
        XCTAssertFalse(sut.items.isEmpty)
        XCTAssertEqual(sut.items.count, expectedNumberOfItems)
    }

}
// MARK: - clean
extension TapListVModelTests {
    func test_clean_insert_and_remove_them_all_should_succeed() {
        // given
        let cleanExpectation = XCTestExpectation(description: "delete decrease items collection")
        var cleanActionLaunched = false

        // when
        sut.add()
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                if cleanActionLaunched {
                    cleanExpectation.fulfill()
                }
                if !self.sut.items.isEmpty, !cleanActionLaunched {
                    cleanActionLaunched.toggle()
                    self.sut.cleanData()
                }
            })

        // then
        wait(for: [cleanExpectation], timeout: cleanTimeOut)
        XCTAssertTrue(sut.items.isEmpty)
    }
}
