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
    
    var bookTitle: String = String()
    var bookRate: Double = 0
    var bookOverView: String = String()
    var coverImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = bookTitle
        let oneAndHalfStarsCount = countingStar(with: bookRate)
        (0...oneAndHalfStarsCount.one - 1).forEach { i in
            starCollection[i].image = UIImage(systemName: "star.fill")
            starCollection[i].tintColor = .systemYellow
        }
        
        let halfStarIndex = oneAndHalfStarsCount.one
        let halfStarCount = oneAndHalfStarsCount.half
        starCollection[halfStarIndex].image = halfStarCount == 1 ? UIImage(systemName: "star.fill.left") : UIImage(systemName: "star")
        starCollection[halfStarIndex].tintColor = halfStarCount == 1 ? .systemYellow : .black
        overViewTextView.text = bookOverView
        coverImageView.image = coverImage
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
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
