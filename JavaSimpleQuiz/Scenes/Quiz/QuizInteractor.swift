//
//  QuizInteractor.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import UIKit

protocol QuizBusinessLogic {
}

protocol QuizDataStore {
}

class QuizInteractor: QuizBusinessLogic, QuizDataStore {
  var presenter: QuizPresentationLogic?
  var worker: QuizWorker?
}
