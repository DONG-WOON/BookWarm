//
//  DetailViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book = Book(title: String(), overview: String(), score: 0)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBackgroundView.layer.cornerRadius = 10
        bottomBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        update(with: book)
    }
    
    ///prepareForReuse
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print("🔥 ",#function)
    }
    
    private func update(with book: Book) {
        titleLabel.text = book.title
        coverImageView.image = UIImage(named: book.title)
        rankLabel.text = "평균★\(book.score)점"
        overViewLabel.text = book.overview
    }
}
