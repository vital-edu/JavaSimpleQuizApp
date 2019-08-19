//
//  QuizWorker.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import UIKit

class QuizWorker {
    var quizStore: QuizStoreProtocol

    init(quizStore: QuizStoreProtocol) {
        self.quizStore = quizStore
    }

    func fetchQuiz(completionHandler: @escaping (Quiz?) -> Void) {
        quizStore.fetchQuiz { (quiz: () throws -> Quiz?) -> Void in
            do {
                let quiz = try quiz()
                DispatchQueue.main.async {
                    completionHandler(quiz)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
    }
}
// MARK: - Quiz store API

protocol QuizStoreProtocol {
    // MARK: CRUD operations

    func fetchQuiz(completionHandler: @escaping (() throws -> Quiz?) -> Void)
}

// MARK: - Quiz store CRUD operation results

enum QuizStoreResult<U> {
    case Success(result: U)
    case Failure(error: QuizStoreError)
}

// MARK: - Quiz store CRUD operation errors

enum QuizStoreError: Equatable, Error {
    case CannotFetch(String)
}
