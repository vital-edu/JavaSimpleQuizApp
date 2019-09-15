//
//  DefaultFont.swift
//  JavaSimpleQuiz
//
//  Created by Eduardo Vital Alencar Cunha on 8/18/19.
//  Copyright (c) 2019 Eduardo Vital Alencar Cunha. All rights reserved.
//

import Foundation
import UIKit

struct DefaultFont {
    public static var titleFont: UIFont {
        let size: CGFloat = 34
        return UIFont(name: ".SFUIDisplay-Bold", size: size) ??
            UIFont.boldSystemFont(ofSize: size)
    }

    public static var bodyFont: UIFont {
        let size: CGFloat = 17
        return UIFont(name: ".SFUIDisplay-Regular", size: size) ??
            UIFont.systemFont(ofSize: size)
    }

    public static var buttonFont: UIFont {
        let size: CGFloat = 17
        return UIFont(name: ".SFUIDisplay-SemiBold", size: size) ??
            UIFont.systemFont(ofSize: size, weight: .semibold)
    }
}
