//
//  AnswerView.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation
import UIKit

class AnswerView : UIView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    private let cellRegisterId = "AnswerViewCell"
    private let searchBar = UISearchBar()
    private var answerKey: [String] = []
    private var userAnswers: [String] = []

    var delegate: AnswerViewDelegate?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: cellRegisterId
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
        tableView.allowsSelection = false

        return tableView
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

    // MARK: Setter
    func set(answerKey: [String]) {
        self.answerKey = answerKey
        self.searchBar.text = nil
        self.searchBar.isUserInteractionEnabled = false
        self.userAnswers = []
        self.searchBar.resignFirstResponder()

        self.tableView.reloadData()
    }

    func set(answerCanBeInserted: Bool) {
        self.searchBar.isUserInteractionEnabled = answerCanBeInserted
    }

    // MARK: - View Setup

    private func setupView() {
        searchBar.delegate = self

        self.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    // MARK: - TableView Delegate and Data Source

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBar.placeholder = "Insert Word"
        searchBar.isUserInteractionEnabled = false
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .white
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.setPositionAdjustment(
            UIOffset(horizontal: -20, vertical: 0),
            for: .search
        )

        return searchBar
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAnswers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellRegisterId)!
        cell.textLabel?.text = userAnswers[indexPath.row]

        return cell
    }

    // MARK: - SearchBar Delegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let userInput = searchBar.text,
            let index = answerKey.firstIndex(of: userInput.lowercased()) {
            answerKey.remove(at: index)
            userAnswers.append(userInput.capitalized)
            delegate?.update(score: userAnswers.count)
            tableView.reloadData()
        }
        searchBar.text = nil
    }
}

protocol AnswerViewDelegate {
    func update(score: Int)
}
