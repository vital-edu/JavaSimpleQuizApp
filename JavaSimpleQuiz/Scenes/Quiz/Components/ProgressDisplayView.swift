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
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 1, green: 0.51, blue: 0, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

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
    }

    private func setupConstraints() {
        let margin: CGFloat = 16
        let buttonHeight: CGFloat = 44

        stackView.topAnchor
            .constraint(equalTo: self.topAnchor, constant: margin)
            .isActive = true
        stackView.leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
            .isActive = true
        stackView.trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
            .isActive = true

        button.topAnchor
            .constraint(equalTo: stackView.bottomAnchor, constant: margin)
            .isActive = true
        button.leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
            .isActive = true
        button.trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
            .isActive = true
        button.bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
            .isActive = true
        button.heightAnchor
            .constraint(equalToConstant: buttonHeight)
            .isActive = true
    }
}