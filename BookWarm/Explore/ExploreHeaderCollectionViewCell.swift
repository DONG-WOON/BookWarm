//
//  ExploreHeaderCollectionViewCell.swift
//  BookWarm
//
//  Created by 서동운 on 8/2/23.
//

import UIKit

class ExploreHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 2
    }

    override func prepareForReuse() {
        coverImageView.image = nil
    }
    
    func update(with book: Book) {
        coverImageView.image = UIImage(named: book.title ?? "")
    }
}
