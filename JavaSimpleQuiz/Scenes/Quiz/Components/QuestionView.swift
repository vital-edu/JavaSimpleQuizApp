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
        self.font = UIFont(name: ".SFUIDisplay-Bold", size: 34)
        self.text = "What are all the java Keywords?"
    }
}
