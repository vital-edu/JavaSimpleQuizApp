//
//  QuizViewController.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import UIKit

protocol QuizDisplayLogic: class {
    func displayFetchedQuiz(viewModel: ShowQuiz.ViewModel)
}

class QuizViewController: UIViewController, QuizDisplayLogic {
    var quizView = QuizView();
    var interactor: QuizBusinessLogic?
    var router: (NSObjectProtocol & QuizRoutingLogic & QuizDataPassing)?
    var loadingView: UIVisualEffectView?

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchQuiz()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(quizView)
        self.setupWaitingView()

        quizView.translatesAutoresizingMaskIntoConstraints = false

        // quiz view constraints
        let topMargin : CGFloat = 44;
        quizView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: topMargin
        ).isActive = true
        quizView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        quizView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
        quizView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor
        ).isActive = true
    }

    func setupWaitingView() {
        loadingView = LoadingView()
        self.view.addSubview(loadingView!)

        loadingView!.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        loadingView!.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        loadingView!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingView!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    // MARK: - Fetch orders
    func fetchQuiz() {
        let request = ShowQuiz.Request()
        interactor?.fetchQuiz(request: request)
    }

    func displayFetchedQuiz(viewModel: ShowQuiz.ViewModel) {
        quizView.update(withModel: viewModel)
        loadingView?.removeFromSuperview()
    }
}
