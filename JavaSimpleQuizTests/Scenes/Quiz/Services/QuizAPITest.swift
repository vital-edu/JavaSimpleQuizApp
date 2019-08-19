//
//  QuizAPITest.swift
//  JavaSimpleQuizTests
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

@testable import JavaSimpleQuiz
import XCTest

class QuizAPITest: XCTestCase {
    // MARK: - Subject under test

    var sut: QuizAPI!
    var testQuiz: Quiz?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupOrdersAPI()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupOrdersAPI() {
        sut = QuizAPI()
    }

    // MARK: - Test CRUD operations

    func testFetchOrderShouldReturnQuiz() {
        // Given
        let expect = expectation(description: "Wait for fetchQuiz() to return")

        // When
        var fetchedQuiz: Quiz?
        var fetchQuizError: QuizStoreError?

        sut.fetchQuiz { (quiz: () throws -> Quiz?) in
            do {
                fetchedQuiz = try quiz()
            } catch let error as QuizStoreError {
                fetchQuizError = error
            } catch {}
            expect.fulfill()
        }

        // Then
        waitForExpectations(timeout: 2)

        XCTAssertNotNil(fetchedQuiz)
        XCTAssertEqual(fetchedQuiz!.question, "What are all the java keywords?")
        XCTAssertEqual(fetchedQuiz?.answers.count, 50)
        XCTAssertNil(fetchQuizError, "fetchQuiz() should not return an error")
    }
}
