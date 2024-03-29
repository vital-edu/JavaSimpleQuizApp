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
    private let timeFormat = "%02i:%02i"
    private let scoreFormat = "%02i/%02i"
    private let timerLabel = UILabel()
    private let scoreLabel = UILabel()
    private let startButtonTitle = "Start"
    private let restartButtonTitle = "Restart"

    private var isPlaying = false
    private var timer: Timer?
    var delegate: ProgressDisplayDelegate?

    private var remainingTime: Int = 0 {
        didSet {
            let minutes = Int(self.remainingTime) / 60 % 60
            let seconds = Int(self.remainingTime) % 60

            self.timerLabel.text = String(format: timeFormat, minutes, seconds)
        }
    }

    private var totalAnswers: Int = 0 {
        didSet {
            updateScore()
        }
    }

    private var correctAnswers: Int = 0 {
        didSet {
            updateScore()
        }
    }

    private func updateScore() {
        scoreLabel.text = String(
            format: scoreFormat, self.correctAnswers, self.totalAnswers
        )
    }

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 1, green: 0.51, blue: 0, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startReset), for: .touchUpInside)

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

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: Setters

    func set(withModel model: ShowQuiz.ViewModel.ProgressDisplay) {
        self.correctAnswers = 0
        self.totalAnswers = model.totalAnswers
        self.remainingTime = model.time
        self.button.setTitle(startButtonTitle, for: .normal)
        self.isPlaying = false
    }

    func set(correctAnswers: Int) {
        if (correctAnswers == totalAnswers) {
            timer?.invalidate()
            timer = nil
        }
        self.correctAnswers = correctAnswers
    }

    // MARK: - Selectors

    @objc fileprivate func startReset() {
        if self.isPlaying {
            self.timer?.invalidate()
            self.timer = nil
            self.delegate?.reset()

            self.button.setTitle("Start", for: .normal)
        } else {
            self.delegate?.answer(isAllowed: true)

            self.timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(self.updateCountdown),
                userInfo: nil,
                repeats: true
            )

            self.button.setTitle("Reset", for: .normal)
        }

        self.isPlaying = !self.isPlaying
    }

    @objc fileprivate func updateCountdown() {
        self.remainingTime -= 1

        if remainingTime <= 0 {
            self.timer?.invalidate()
            self.timer = nil
            self.remainingTime = 0
            self.delegate?.timeIsOver(score: correctAnswers)
        }
    }

    // MARK: - Setup View

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

protocol ProgressDisplayDelegate {
    func answer(isAllowed: Bool)
    func timeIsOver(score: Int)
    func reset()
}
