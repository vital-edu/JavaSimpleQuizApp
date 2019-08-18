//
//  QuizView.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation
import UIKit

class QuizView : UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        self.distribution = .fill
        self.alignment = .center
        self.axis = .vertical

        let questionView = QuestionView()
        let answerView = AnswerView()
        let progressDisplayView = ProgressDisplayView()

        self.addArrangedSubview(questionView)
        self.addArrangedSubview(answerView)
        self.addArrangedSubview(progressDisplayView)

        questionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        questionView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -16).isActive = true

        answerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        answerView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -16).isActive = true

        progressDisplayView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}
