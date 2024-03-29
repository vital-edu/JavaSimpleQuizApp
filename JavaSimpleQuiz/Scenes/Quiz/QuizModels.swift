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
        var question: String
        var answers: [String]
        var progressDisplay: ProgressDisplay
        var result: Result?

        struct ProgressDisplay {
            var time: Int
            var discoveredAnswers: Int
            var totalAnswers: Int
        }

        enum Result {
            case won
            case lost(Score)

            struct Score {
                let pontuation: Int
                let total: Int
            }
        }
    }
}
