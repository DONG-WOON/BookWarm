//
//  DetailViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var starCollection: [UIImageView]!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var overViewTextView: UITextView!
    
    var book: Book = Book(title: String(), overview: String(), rate: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    ///prepareForReuse
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        update(with: book)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func update(with book: Book) {
        self.titleLabel.text = book.title
        self.overViewTextView.text = book.overview
        self.coverImageView.image = UIImage(named: book.title)
        
        let oneAndHalfStarsCount = countingStar(with: book.rate)
        (0...oneAndHalfStarsCount.one - 1).forEach { i in
            starCollection[i].image = UIImage(systemName: "star.fill")
        }
        
        let halfStarIndex = oneAndHalfStarsCount.one
        let halfStarCount = oneAndHalfStarsCount.half
        starCollection[halfStarIndex].image = halfStarCount == 1 ? UIImage(systemName: "star.fill.left") : UIImage(systemName: "star")
    }
    
    typealias Stars = (one: Int, half: Int)
    
    func countingStar(with rate: Double) -> Stars {
        let roundedRate = rate.rounded()
        let count = Int(roundedRate / 2)
        if Int(roundedRate) % 2 == 1 {
            return Stars(one: count, half: 1)
        } else {
            return Stars(one: count, half: 0)
        }
    }
}
