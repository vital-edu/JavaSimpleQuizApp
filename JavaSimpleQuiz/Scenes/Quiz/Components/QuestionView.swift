//
//  QuestionView.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation
import UIKit

class QuestionView : UILabel {
    public var question: String {
        get {
            return self.text ?? ""
        }
        set(newValue) {
            self.text = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = DefaultFont.titleFont
    }
}
