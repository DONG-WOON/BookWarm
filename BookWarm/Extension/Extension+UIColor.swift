//
//  Extension+UIColor.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

extension UIColor {
    static func getColor(rgb: Color) -> UIColor {
        return UIColor(
            red:   rgb.red,
            green: rgb.green,
            blue:  rgb.blue,
            alpha: rgb.alpha
        )
    }
}
