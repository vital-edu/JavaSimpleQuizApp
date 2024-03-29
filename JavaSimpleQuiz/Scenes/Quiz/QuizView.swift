//
//  QuizView.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation
import UIKit

class QuizView : UIStackView, AnswerViewDelegate, ProgressDisplayDelegate {
    private let questionView = QuestionView()
    private let answerView = AnswerView()
    private let progressDisplayView = ProgressDisplayView()
    private var model: ShowQuiz.ViewModel!

    var delegate: QuizViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func update(withModel model: ShowQuiz.ViewModel) {
        questionView.question = model.question
        progressDisplayView.set(withModel: model.progressDisplay)
        answerView.set(answerKey: model.answers)

        answerView.delegate = self
        progressDisplayView.delegate = self

        self.model = model
    }

    private func setupView() {
        self.distribution = .fill
        self.alignment = .center
        self.axis = .vertical

        self.addArrangedSubview(questionView)
        self.addArrangedSubview(answerView)
        self.addArrangedSubview(progressDisplayView)

        questionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        questionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true

        answerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        answerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true

        progressDisplayView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }

    // MARK: - ProgressDisplayDelegate

    func answer(isAllowed: Bool) {
        answerView.set(answerCanBeInserted: isAllowed)
    }

    func timeIsOver(score: Int) {
        let score = ShowQuiz.ViewModel.Result.Score(
            pontuation: score,
            total: model.progressDisplay.totalAnswers
        )
        delegate?.endGame(withResult: ShowQuiz.ViewModel.Result.lost(score))
    }

    func reset() {
        self.progressDisplayView.set(withModel: self.model.progressDisplay)
        self.answerView.set(answerKey: model.answers)
    }

    // MARK: - AnswerViewDelegate

    func update(score: Int) {
        progressDisplayView.set(correctAnswers: score)
        if (score == model.progressDisplay.totalAnswers) {
            delegate?.endGame(withResult: .won)
        }
    }
}

protocol QuizViewDelegate {
    func endGame(withResult result: ShowQuiz.ViewModel.Result)
}
