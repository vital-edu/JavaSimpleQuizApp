//
//  QuizRouter.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import UIKit

@objc protocol QuizRoutingLogic {
}

protocol QuizDataPassing {
  var dataStore: QuizDataStore? { get }
}

class QuizRouter: NSObject, QuizRoutingLogic, QuizDataPassing {
  weak var viewController: QuizViewController?
  var dataStore: QuizDataStore?

  // MARK: Routing

  // MARK: Navigation

  // MARK: Passing data
}
