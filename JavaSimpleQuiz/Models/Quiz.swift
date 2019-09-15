//
//  Quiz.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation

class Quiz {
    // MARK: Contact info
    var question: String
    var answers: [String]

    init(fromData data: Data) {
        let jsonResponse = try! JSONSerialization.jsonObject(
            with:data, options: []
        )
        let jsonDict = jsonResponse as! [String: Any]

        self.question = jsonDict["question"] as! String
        self.answers = jsonDict["answer"] as! [String]
    }

    init(question: String, answers: [String]) {
        self.question = question
        self.answers = answers
    }
}
