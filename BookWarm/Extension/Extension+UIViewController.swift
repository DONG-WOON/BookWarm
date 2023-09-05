//
//  Extension+UIViewController.swift
//  BookWarm
//
//  Created by 서동운 on 8/2/23.
//

import UIKit
import SnapKit

extension UIViewController {
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    func showErrorMessage(message: String?) {
        let alert = UIAlertController(title: "주의", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
