//
//  MainCollectionViewCell.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MainCollectionViewCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        rateLabel.font = .systemFont(ofSize: 12)
        rateLabel.textColor = .white
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        rateLabel.text = nil
        coverImageView.image = nil
    }
    
    func update(with book: Book) {
        titleLabel.text = book.title
        rateLabel.text = "\(book.rate)"
        coverImageView.image = UIImage(named: book.title)
    }
}
