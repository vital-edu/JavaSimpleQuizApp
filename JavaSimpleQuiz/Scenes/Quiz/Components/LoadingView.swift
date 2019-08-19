//
//  LoadingView.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation
import UIKit

class LoadingView : UIVisualEffectView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setupView()
    }

    private func setupView() {
        let width: CGFloat = 200
        let height: CGFloat = 140

        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerView = UIView()
        centerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        centerView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "Loading..."
        label.font = DefaultFont.buttonFont
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        centerView.addSubview(label)
        centerView.addSubview(activityIndicator)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.layer.cornerRadius = 20

        self.effect = UIBlurEffect(style: .dark)
        self.contentView.addSubview(centerView)
        self.translatesAutoresizingMaskIntoConstraints = false

        label.centerXAnchor
            .constraint(equalTo: centerView.centerXAnchor)
            .isActive = true
        label.centerYAnchor
            .constraint(equalTo: centerView.centerYAnchor, constant: 30)
            .isActive = true

        activityIndicator.centerXAnchor
            .constraint(equalTo: centerView.centerXAnchor)
            .isActive = true
        activityIndicator.centerYAnchor
            .constraint(equalTo: centerView.centerYAnchor, constant: -20)
            .isActive = true

        centerView.widthAnchor
            .constraint(equalToConstant: width).isActive = true
        centerView.heightAnchor
            .constraint(equalToConstant: height).isActive = true
        centerView.centerYAnchor
            .constraint(equalTo: self.centerYAnchor).isActive = true
        centerView.centerXAnchor
            .constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
