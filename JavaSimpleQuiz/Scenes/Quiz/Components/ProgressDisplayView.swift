//
//  ProgressDisplayView.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation
import UIKit

class ProgressDisplayView : UIView {
    let timeFormat = "%02i:%02i:%02i"
    let timerLabel = UILabel()
    let scoreLabel = UILabel()

    private var answers: [String] = []

    private var remainingTime: Int = 0 {
        didSet (newValue) {
            let hours = Int(newValue) / 3600
            let minutes = Int(newValue) / 60 % 60
            let seconds = Int(newValue) % 60

            timerLabel.text = String(format: timeFormat, hours, minutes, seconds)
            self.remainingTime = newValue
        }
    }

    private var correctAnswers: Int = 0 {
        didSet(newValue) {
            scoreLabel.text = String(format: "%i/%i", newValue, 0)
        }
    }

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 1, green: 0.51, blue: 0, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scoreLabel.font = DefaultFont.buttonFont
        timerLabel.font = DefaultFont.buttonFont

        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(timerLabel)

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func set(withModel model: ShowQuiz.ViewModel.ProgressDisplay) {
        self.answers = model.answers
    }

    private func setupView() {
        self.backgroundColor = UIColor(
            red: 0.96,
            green: 0.96,
            blue: 0.96,
            alpha: 1
        )

        self.addSubview(stackView)
        self.addSubview(button)

        setupConstraints()

        remainingTime = 5 * 60
        correctAnswers = 0
    }

    private func setupConstraints() {
        let margin: CGFloat = 16
        let buttonHeight: CGFloat = 44

        stackView.topAnchor
            .constraint(equalTo: self.topAnchor, constant: margin)
            .isActive = true
        stackView.leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: margin)
            .isActive = true
        stackView.trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -margin)
            .isActive = true

        button.topAnchor
            .constraint(equalTo: stackView.bottomAnchor, constant: margin)
            .isActive = true
        button.leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: margin)
            .isActive = true
        button.trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -margin)
            .isActive = true
        button.bottomAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -margin)
            .isActive = true
        button.heightAnchor
            .constraint(equalToConstant: buttonHeight)
            .isActive = true
    }
}
