//
//  Extension+UIView.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    func rounded(cornerRadius: CGFloat, isShadowBackground: Bool = false) {
        self.layer.cornerRadius = cornerRadius
        if isShadowBackground {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 4, height: 4)
            self.layer.shadowRadius = cornerRadius
            self.layer.shadowOpacity = 0.5
        }
    }
    
    func bordered(cornerRadius: CGFloat = 5) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
