//
//  QuizApi.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation

class QuizAPI: QuizStoreProtocol {
    let url = URL(string: "https://codechallenge.arctouch.com/quiz/java-keywords")!

    init() {
    }

    // MARK: - CRUD operations - Optional error

    func fetchQuiz(completionHandler: @escaping (() throws -> Quiz?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data {
                completionHandler { return Quiz.init(fromData: data) }
            } else {
                completionHandler { throw QuizStoreError.CannotFetch("error") }
            }
        }

        task.resume()
    }
}

