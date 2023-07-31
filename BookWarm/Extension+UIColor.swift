//
//  Extension+UIColor.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 0.7
        )
    }
}
