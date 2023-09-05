//
//  ExploreTableViewCell.swift
//  BookWarm
//
//  Created by 서동운 on 8/2/23.
//

import UIKit
import Kingfisher

class ExploreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coverImageView.layer.cornerRadius = 5
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        infoLabel.textColor = .systemGray4
        infoLabel.font = .systemFont(ofSize: 14)
    }
    
    func update(with book: Book) {
        if book.thumbnail != nil {
            coverImageView.kf.setImage(with: URL(string: book.thumbnail ?? ""))
        } else {
            coverImageView.image = UIImage(named: "contents_noImage")
        }
        titleLabel.text = book.title
        //        infoLabel.text = book.datetime + "∙책"
        
    }
}
