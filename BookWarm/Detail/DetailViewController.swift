//
//  DetailViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

// domb: 텍스트 뷰 키보드 레이아웃 설정 ⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️

enum MemoAction {
    case read
    case edit
}

final class DetailViewController: UIViewController {
    
    var book: Book = Book()
    var action: MemoAction = .read
    
    private let placeholderText = "메모를 입력해주세요."
    private var editButtonTitle = "메모 수정" {
        didSet {
            memoButton.setTitle(editButtonTitle, for: .normal)
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserMemoData()
        
        check(action)
        configureMemoTextView()
        configureViews()
        update(with: book)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func memoButtonDidTapped(_ sender: UIButton) {

        let memoIsEditable = sender.titleLabel?.text == "메모 수정"
        
        memoTextView.isEditable = memoIsEditable
        memoTextView.becomeFirstResponder()
        
        editButtonTitle = memoIsEditable ? "메모 완료" : "메모 수정"
        sender.backgroundColor = memoIsEditable ? .systemGray4 : .white
        
        if !memoIsEditable {
            if let memo = memoTextView.text {
                guard var dic = UserDefaults.standard.dictionary(forKey: "myMemo") as? [String: String] else {
                    let dic = [book.title: memo]
                    UserDefaults.standard.setValue(dic, forKey: "myMemo")
                    return
                }
                dic[book.title] = memo
                UserDefaults.standard.setValue(dic, forKey: "myMemo")
            }
        }
    }
    
    private func loadUserMemoData() {
        guard let dic = UserDefaults.standard.dictionary(forKey: "myMemo") as? [String: String] else { return }
        let memo = dic[book.title]
        memoTextView.text = memo
    }
    
    private func check(_ action: MemoAction) {
        switch action {
        case .read:
            navigationItem.leftBarButtonItem = UIBarButtonItem(primaryAction: dismissAction)
        case .edit:
            memoButton.isHidden = false
        }
    }
    
    private func update(with book: Book) {
        titleLabel.text = book.title
        coverImageView.image = UIImage(named: book.title)
        rankLabel.text = "평균★\(book.rate)점"
        overViewTextView.text = book.overview
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
    }
}
