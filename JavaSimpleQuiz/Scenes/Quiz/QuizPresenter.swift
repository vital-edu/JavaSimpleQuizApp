//
//  QuizPresenter.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import UIKit

protocol QuizPresentationLogic {
    func presentFetchedQuiz(response: ShowQuiz.Response)
}

class QuizPresenter: QuizPresentationLogic {
    weak var viewController: QuizDisplayLogic?

    func presentFetchedQuiz(response: ShowQuiz.Response) {
        let progressDisplay = ShowQuiz.ViewModel.ProgressDisplay(
            time: 5,
            discoveredAnswers: 0,
            totalAnswers: response.quiz.answers.count,
            answers: []
        )
        let viewModel = ShowQuiz.ViewModel(
            question: response.quiz.question,
            answers: response.quiz.answers,
            progressDisplay: progressDisplay
        )

        viewController?.displayFetchedQuiz(viewModel: viewModel)
    }
}
