//
//  Extension+UICollectionViewFlowLayout.swift
//  BookWarm
//
//  Created by 서동운 on 8/1/23.
//

import UIKit

class DefaultCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let spacing: CGFloat = 10.0
    let deviceWidth = UIScreen.main.bounds.width
    lazy var itemWidth = (self.deviceWidth - (self.spacing * 3)) / 2
    
    init(spacing: CGFloat, cellCount: Int) {
        super.init()
        
        itemWidth = (self.deviceWidth - (spacing * CGFloat(cellCount + 1))) / CGFloat(cellCount)
        self.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    convenience init(cellCount: Int) {
        self.init(spacing: 10, cellCount: cellCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
