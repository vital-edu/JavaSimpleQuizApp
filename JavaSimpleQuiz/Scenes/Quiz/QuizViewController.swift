//
//  QuizViewController.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import UIKit

protocol QuizDisplayLogic: class {
}

class QuizViewController: UIViewController, QuizDisplayLogic {
  var interactor: QuizBusinessLogic?
  var router: (NSObjectProtocol & QuizRoutingLogic & QuizDataPassing)?

  // MARK: Object lifecycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: Setup

  private func setup() {
    let viewController = self
    let interactor = QuizInteractor()
    let presenter = QuizPresenter()
    let router = QuizRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  // MARK: Routing

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }

  // MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    let quizView = QuizView();
    quizView.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(quizView)

    // quiz view constraints
    let horizontalMargin : CGFloat = 16;
    let topMargin : CGFloat = 44;
    quizView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: topMargin
    ).isActive = true
    quizView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
        constant: horizontalMargin
    ).isActive = true
    quizView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: -horizontalMargin
    ).isActive = true
    quizView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor
    ).isActive = true
  }
}
