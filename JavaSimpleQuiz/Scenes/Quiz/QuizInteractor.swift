//
//  QuizInteractor.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import UIKit

protocol QuizBusinessLogic {
    func fetchQuiz(request: ShowQuiz.Request)
}

protocol QuizDataStore {
    var quiz: Quiz? { get }
}

class QuizInteractor: QuizBusinessLogic, QuizDataStore {
    var quiz: Quiz?
    var presenter: QuizPresentationLogic?
    var worker = QuizWorker(quizStore: QuizAPI())

    // MARK: - Fetch Quiz

    func fetchQuiz(request: ShowQuiz.Request) {
        worker.fetchQuiz { (quiz) in
            self.quiz = quiz

            if let quiz = quiz {
                let response = ShowQuiz.Response(quiz: quiz)
                self.presenter?.presentFetchedQuiz(response: response)
            }
        }
    }
}
