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
    
    var favoriteButtonAction: () -> Void = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        scoreLabel.font = .systemFont(ofSize: 12)
        scoreLabel.textColor = .white
        favoriteButton.tintColor = .black
        self.rounded(cornerRadius: 10, isShadowBackground: true)
        
        favoriteButton.addTarget(self, action: #selector(favorite), for: .touchUpInside)
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        scoreLabel.text = nil
        coverImageView.image = nil
        favoriteButton.imageView?.image = UIImage(systemName: "heart")
    }
    
    func update(book: Book) {
        titleLabel.text = book.title
//        scoreLabel.text = "\(book.rate ?? "")"
        coverImageView.kf.setImage(with: URL(string: book.thumbnail ?? ""))
        backgroundColor = .getColor(rgb: Color())
        
        let heartImage = book.isFavorite ? UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) : UIImage(systemName: "heart")
        
        favoriteButton.setImage(heartImage, for: .normal)
    }
    
    @objc func favorite() {
        favoriteButtonAction()
    }
}
