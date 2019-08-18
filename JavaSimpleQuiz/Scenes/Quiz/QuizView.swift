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
        self.alignment = .fill
        self.axis = .vertical

        self.addArrangedSubview(QuestionView())
        self.addArrangedSubview(AnswerView())
        self.addArrangedSubview(ProgressDisplayView())
    }
}