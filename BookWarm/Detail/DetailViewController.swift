//
//  DetailViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

enum TransitionType {
    case push
    case present
}

class DetailViewController: UIViewController {
    
    var book: Book = Book()
    var transitionType: TransitionType = .push
    lazy var dismissAction = UIAction(image: UIImage(systemName: "xmark")) { _ in
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch transitionType {
        case .push:
            break
        case .present:
            navigationItem.leftBarButtonItem = UIBarButtonItem(primaryAction: dismissAction)
        }
        
        bottomBackgroundView.layer.cornerRadius = 10
        bottomBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        update(with: book)
    }
    
    ///prepareForReuse
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func update(with book: Book) {
        titleLabel.text = book.title
        coverImageView.image = UIImage(named: book.title)
        rankLabel.text = "평균★\(book.rate)점"
        overViewLabel.text = book.overview
    }
}
