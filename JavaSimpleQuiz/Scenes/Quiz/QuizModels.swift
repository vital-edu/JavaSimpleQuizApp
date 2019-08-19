//
//  QuizModels.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import UIKit

enum ShowQuiz {
  // MARK: Use cases

    struct Request {
    }
    struct Response {
        var quiz: Quiz
    }
    struct ViewModel {
        struct Question {
            var text: String
        }
        struct Answer {
            var text: String
        }
        struct ProgressDisplay {
            var time: Double
            var discoveredAnswers: Int
            var totalAnswers: Int
            var answers: [String]
        }
        var answers: [Answer]
    }
}
