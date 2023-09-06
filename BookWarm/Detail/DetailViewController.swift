//
//  DetailViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit
import Kingfisher
import RealmSwift

enum MemoAction {
    case read
    case edit
}

final class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    var book: Book = Book()
    var action: MemoAction = .read
    
    private let placeholderText = "메모를 입력해주세요."
    lazy var memoIsEditing = false
    
    lazy var dismissAction = UIAction(image: UIImage(systemName: "xmark")) { _ in
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var memoButton: UIButton!
    @IBOutlet weak var addMyBooksButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserMemoData()
        check(action)
        configureMemoTextView()
        configureViews()
        update(with: book)
        toggleAddMyBooksButton()
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addMyBooks(_ sender: UIButton) {
        
        let sameBook = realm.objects(BookTable.self).where { $0.isbn == book.isbn }
        do {
            try realm.write {
                if sameBook.count == 0 {
                    let bookTable = BookTable(book: book)
                    realm.add(bookTable)
                    try realm.saveImage(path: "\(book.id).jpeg", image: coverImageView.image)
                } else {
                    try realm.deleteImageFromDocument(fileName: "\(book.id).jpeg")
                    realm.delete(sameBook)
                }
            }
        } catch {
            showErrorMessage(message: error.localizedDescription)
        }
        
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    @IBAction func memoButtonDidTapped(_ sender: UIButton) {
        memoIsEditing.toggle()
        memoTextView.isEditable = memoIsEditing
        
        if memoIsEditing {
            sender.setTitle("메모 완료", for: .normal)
            sender.backgroundColor = .systemGray4
        } else {
            memoButton.setTitle("메모 수정", for: .normal)
            sender.becomeFirstResponder()
            sender.backgroundColor = .white
        }
        
        guard let bookTable = realm.object(ofType: BookTable.self, forPrimaryKey: book.isbn) else {
            showErrorMessage(message: "나의 책장에 저장하지않아서 메모를 저장할 수 없어요")
            return
        }
        
        try! realm.write {
            bookTable.memo = memoTextView.text
            realm.add(bookTable, update: .modified)
        }
    }
    
    private func loadUserMemoData() {
        guard let dic = UserDefaults.standard.dictionary(forKey: "myMemo") as? [String: String] else { return }
        let memo = dic[book.title]
        memoTextView.text = memo
    }
    
    func toggleAddMyBooksButton() {
        let realm = try! Realm()
        
        let sameBook = realm.objects(BookTable.self).where { $0.isbn == book.isbn }
        if sameBook.count == 1 {
            addMyBooksButton.setTitle("책장에서 제거", for: .normal)
        } else {
            addMyBooksButton.setTitle("책장에 추가", for: .normal)
        }
    }
    
    private func check(_ action: MemoAction) {
        switch action {
        case .read:
            navigationItem.leftBarButtonItem = UIBarButtonItem(primaryAction: dismissAction)
            memoButton.isHidden = true
            memoTextView.isHidden = true
        case .edit:
            memoButton.isHidden = false
        }
    }
    
    private func update(with book: Book) {
        titleLabel.text = book.title
        coverImageView.kf.setImage(with: URL(string: book.thumbnail ?? ""))
        overViewTextView.text = book.overview
        addMyBooksButton.isEnabled = true
        if let memo = book.memo, !memo.isEmpty {
            memoTextView.textColor = .black
            memoTextView.text = memo
        } else {
            memoTextView.textColor = .gray
            memoTextView.text = placeholderText
        }
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        // Tip: 사용자가 placeholderText와 동일하게 작성했을 경우 에러 처리를 위해 color로 변경.
        if textView.textColor == .gray, memoTextView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
        
        return true
    }
}

extension DetailViewController {
    fileprivate func configureMemoTextView() {
        memoTextView.delegate = self
        if memoTextView.text.isEmpty {
            memoTextView.isSelectable = false
            memoTextView.textColor = .gray
            memoTextView.text = placeholderText
        }
    }
    
    fileprivate func configureViews() {
        bottomBackgroundView.layer.cornerRadius = 10
        bottomBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        memoTextView.bordered()
        memoButton.bordered()
        addMyBooksButton.isEnabled = false
    }
}
