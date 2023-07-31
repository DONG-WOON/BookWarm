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
    @IBOutlet weak var overViewTextView: UITextView!
    
    var bookTitle: String = String()
    var bookRate: Double = 0
    var bookOverView: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = bookTitle
        let starCount = countingStar(with: bookRate)
        (0...starCount - 1).forEach { i in
            starCollection[i].image = UIImage(systemName: "star.fill")
            starCollection[i].tintColor = .systemYellow
        }
        overViewTextView.text = bookOverView
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func countingStar(with rate: Double) -> Int {
        let count = Int(rate / 2)
        return count
    }
}
