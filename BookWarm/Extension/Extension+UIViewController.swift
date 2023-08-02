//
//  Extension+UIViewController.swift
//  BookWarm
//
//  Created by 서동운 on 8/2/23.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
