//
//  PersistenceManagerTests.swift
//  CompteTests
//
//  Created by likeadeveloper on 27/12/22.
//

import XCTest
@testable import Compte
import Combine

// MARK: - PersistenceManagerTests
final class PersistenceManagerTests: XCTestCase {
    // MARK: Vars
    var sut: PersistenceManager!
    var cancellable: AnyCancellable?
    private let createTimeOut: TimeInterval = 0.02
    private let fetchTimeOut: TimeInterval = 0.02
    private let updateTimeOut: TimeInterval = 0.02
    private let deleteTimeOut: TimeInterval = 0.02
    private let clearTimeOut: TimeInterval = 0.02

    // MARK: Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PersistenceManager(dataStore: DataStoreMock())
        continueAfterFailure = true
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        cancellable = nil
    }
}
// MARK: - Create
extension PersistenceManagerTests {
    func test_create_new_item_should_succeed() {
        // given
        let object = CompteObject.defaultImplementation()
        let mapper = CompteMapper(object)
        let expectation = XCTestExpectation(description: "insert item and wait until change")

        // when
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
        insertCompteItem(mapper)

        // then
        wait(for: [expectation], timeout: createTimeOut)
        XCTAssertFalse(sut.compteModelCollection.isEmpty)

        let first = sut.compteModelCollection.first
        XCTAssertNotNil(first)
        XCTAssertEqual(first?.id, object.id)
    }
    func test_create_new_item_should_fail() {
        // given
        let mapper = CompteMapper()
        let expectation = XCTestExpectation(description: "insert item and wait until change")
        expectation.isInverted = true

        // when
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
        insertCompteItem(mapper)

        // then
        wait(for: [expectation], timeout: createTimeOut)
        XCTAssertTrue(sut.compteModelCollection.isEmpty)
    }
}
// MARK: - Read
extension PersistenceManagerTests {
    func test_read_existing_item_should_succeed() {
        // given
        let object = CompteObject.defaultImplementation()
        let mapper = CompteMapper(object)
        let expectation = XCTestExpectation(description: "fetch items and wait until receive two changes")
        expectation.expectedFulfillmentCount = 2

        insertCompteItem(mapper)
        sut.fetch(mapper: mapper)

        // when
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })

        // then
        wait(for: [expectation], timeout: fetchTimeOut)
        XCTAssertFalse(sut.compteModelCollection.isEmpty)
    }
    func test_read_existing_item_should_fail() {
        // given
        let mapper = CompteMapper()
        let expectation = XCTestExpectation(description: "fetch items and wait until receive two changes")
        expectation.expectedFulfillmentCount = 2
        expectation.isInverted = true

        sut.add(mapper: mapper)
        sut.fetch(mapper: mapper)

        // when
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })

        // then
        wait(for: [expectation], timeout: fetchTimeOut)
        XCTAssertTrue(sut.compteModelCollection.isEmpty)
    }
}
// MARK: - Update
extension PersistenceManagerTests {
    func test_update_existing_item_should_succeed() {
        // given
        let newName = "updated-object"

        let object = CompteObject.defaultImplementation()
        let mapper = CompteMapper(object)

        let updatedObject = CompteObject(id: object.id, date: object.date, name: newName)
        let updateMapper = CompteMapper(updatedObject)

        let expectation = XCTestExpectation(description: "insert and update item receive two changes")
        expectation.expectedFulfillmentCount = 2

        // when
        insertCompteItem(mapper)
        sut.update(mapper: updateMapper)

        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })

        // then
        wait(for: [expectation], timeout: updateTimeOut)
        XCTAssertFalse(sut.compteModelCollection.isEmpty)
        XCTAssertEqual(sut.compteModelCollection.count, 1)

        let firstItem = sut.compteModelCollection.first
        XCTAssertNotNil(firstItem)
        XCTAssertEqual(firstItem?.id, updatedObject.id)
        XCTAssertEqual(firstItem?.name, updatedObject.name)
        XCTAssertEqual(firstItem?.date, updatedObject.date)
        XCTAssertGreaterThan(firstItem!.lastModified, updatedObject.lastModified)

        XCTAssertEqual(object.id, firstItem?.id)
        XCTAssertNotEqual(object.name, firstItem?.name)
        XCTAssertEqual(object.date, firstItem?.date)
        XCTAssertLessThan(object.lastModified, firstItem!.lastModified)
    }
    func test_update_existing_item_should_fail() {
        // given
        let newName = "updated-object"

        let object = CompteObject.defaultImplementation()
        let mapper = CompteMapper(object)

        let updatedObject = CompteObject(date: Date().timeIntervalSince1970, name: newName)
        let updateMapper = CompteMapper(updatedObject)

        let expectation = XCTestExpectation(description: "insert and update item receive two changes")
        expectation.expectedFulfillmentCount = 2

        // when
        insertCompteItem(mapper)
        sut.update(mapper: updateMapper)
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })

        // then
        wait(for: [expectation], timeout: updateTimeOut)
        XCTAssertFalse(sut.compteModelCollection.isEmpty)
        XCTAssertEqual(sut.compteModelCollection.count, 1)

        let firstItem = sut.compteModelCollection.first
        XCTAssertNotNil(firstItem)
        XCTAssertNotEqual(firstItem?.id, updatedObject.id)
        XCTAssertNotEqual(firstItem?.name, updatedObject.name)
        XCTAssertNotEqual(firstItem?.date, updatedObject.date)
        XCTAssertGreaterThan(firstItem!.lastModified, updatedObject.lastModified)

        XCTAssertEqual(object.id, firstItem?.id)
        XCTAssertEqual(object.name, firstItem?.name)
        XCTAssertEqual(object.date, firstItem?.date)
        XCTAssertLessThan(object.lastModified, firstItem!.lastModified)
    }
}
// MARK: - Delete
extension PersistenceManagerTests {
    func test_delete_existing_should_succeed(){
        // given
        let object = CompteObject.defaultImplementation()
        let mapper = CompteMapper(object)

        var isExpectationTriggered = false
        let expectation = XCTestExpectation(description: "insert and delete item receive two changes")
        expectation.expectedFulfillmentCount = 2

        // when
        sut.add(mapper: mapper)
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                guard !self.sut.compteModelCollection.isEmpty else { return }
                expectation.fulfill()

                if !isExpectationTriggered {
                    isExpectationTriggered.toggle()
                }

                self.sut.delete(mapper: mapper)
            })

        // then
        wait(for: [expectation], timeout: deleteTimeOut)
        XCTAssertTrue(sut.compteModelCollection.isEmpty)
    }
    func test_delete_existing_should_fail(){
        // given
        let object = CompteObject.defaultImplementation()
        let mapper = CompteMapper(object)
        let otherObject = CompteObject.defaultImplementation()
        let otherMapper = CompteMapper(otherObject)

        let expectation = XCTestExpectation(description: "insert and delete item receive two changes")
        expectation.expectedFulfillmentCount = 2
        expectation.isInverted = true

        // when
        sut.add(mapper: mapper)
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                guard !self.sut.compteModelCollection.isEmpty else { return }
                expectation.fulfill()

                self.sut.delete(mapper: otherMapper)
            })

        // then
        wait(for: [expectation], timeout: deleteTimeOut)
        XCTAssertFalse(sut.compteModelCollection.isEmpty)
    }
}
// MARK: - Clear
extension PersistenceManagerTests {
    func test_clear_existing_items_should_succeed() {
        // given
        let numberOfItemsToInsert = 5
        let mappers = Array(repeating: false, count: numberOfItemsToInsert)
            .map { _ in CompteMapper(CompteObject.defaultImplementation()) }

        let expectation = XCTestExpectation(description: "insert and clear items receive two changes")
        expectation.expectedFulfillmentCount = 2

        // when
        mappers.forEach { sut.add(mapper: $0) }
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                if !self.sut.compteModelCollection.isEmpty {
                    self.sut.clear(requireSave: true)
                } else {
                    expectation.fulfill()
                }
            })

        // then
        wait(for: [expectation], timeout: clearTimeOut)
        XCTAssertTrue(sut.compteModelCollection.isEmpty)
    }
    func test_clear_existing_items_should_fail() {
        // given
        let expectation = XCTestExpectation(description: "insert and clear items receive zero changes")
        expectation.isInverted = true

        // when
        cancellable = sut
            .objectWillChange
            .sink(receiveValue: { _ in
                expectation.assertForOverFulfill = true
            })

        // then
        wait(for: [expectation], timeout: clearTimeOut)
        XCTAssertTrue(sut.compteModelCollection.isEmpty)
    }
}

// MARK: - Helper
private extension PersistenceManagerTests {
    func insertCompteItem(_ mapper: CompteMapper = CompteMapper()) {
        sut.add(mapper: mapper, requireSave: true)
    }
}
