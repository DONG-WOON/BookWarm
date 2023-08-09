//
//  MainCollectionViewCell.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        scoreLabel.font = .systemFont(ofSize: 12)
        scoreLabel.textColor = .white
        favoriteButton.tintColor = .black
        self.rounded(cornerRadius: 10, isShadowBackground: true)
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        scoreLabel.text = nil
        coverImageView.image = nil
        favoriteButton.imageView?.image = UIImage(systemName: "heart")
    }
    
    func update(with book: Book) {
        titleLabel.text = book.title
        scoreLabel.text = "\(book.rate)"
        coverImageView.image = UIImage(named: book.title)
        backgroundColor = .getColor(rgb: book.backgroundColor)
        
        let heartImage = book.isFavorite ? UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) : UIImage(systemName: "heart")
        
        favoriteButton.setImage(heartImage, for: .normal)
    }
}
