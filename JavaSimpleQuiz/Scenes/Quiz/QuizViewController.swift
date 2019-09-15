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

class QuizViewController: UIViewController, QuizDisplayLogic, QuizViewDelegate {
    var quizView = QuizView();
    var interactor: QuizBusinessLogic?
    var router: (NSObjectProtocol & QuizRoutingLogic & QuizDataPassing)?
    var loadingView: UIVisualEffectView?
    var bottomViewConstraint: NSLayoutConstraint?

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

        // configure keyboard observers
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(QuizViewController.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(QuizViewController.keyboardWillHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)

        quizView.translatesAutoresizingMaskIntoConstraints = false
        quizView.delegate = self

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
        bottomViewConstraint = quizView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor
        )
        bottomViewConstraint!.isActive = true
    }

    func setupWaitingView() {
        loadingView = LoadingView()
        self.view.addSubview(loadingView!)

        loadingView!.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        loadingView!.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        loadingView!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingView!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    // MARK: - Selectors

    @objc fileprivate func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @objc fileprivate func keyboardWillShow(notification: Notification) {
        guard let constraint = bottomViewConstraint else { return }
        guard let userInfo = notification.userInfo else { return }

        if let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {

            constraint.constant = -keyboardSize.height
            UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    @objc fileprivate func keyboardWillHide(notification: Notification) {
        guard let constraint = bottomViewConstraint else { return }
        guard let userInfo = notification.userInfo else { return }

        if let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            constraint.constant = 0
            UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
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

    // MARK: - QuizViewDelegate

    func endGame(withResult result: ShowQuiz.ViewModel.Result) {
        var title: String!
        var message: String!
        var actionTitle: String!

        switch result {
        case .won:
            title = "Congratulations"
            message = "Good job! You found all the answers on time. Keep up with the great work."
            actionTitle = "Play Again"
        case .lost(let lost):
            title = "Time finished"
            message = "Sorry, time is up! You got \(lost.pontuation) out of \(lost.total) answers"
            actionTitle = "Try Again"
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (_) in
            self.quizView.reset()
        }))
        self.present(alert, animated: true)
    }
}
