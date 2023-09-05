//
//  SearchViewCell.swift
//  BookWarm
//
//  Created by 서동운 on 9/5/23.
//
import UIKit
import Kingfisher

final class SearchViewCell: UITableViewCell {
    
    lazy var coverImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.bordered()
        return view
    }()
      
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray4
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with book: Book) {
        if book.thumbnail != nil {
            coverImageView.kf.setImage(with: URL(string: book.thumbnail ?? ""))
        } else {
            coverImageView.image = UIImage(named: "contents_noImage")
        }
        titleLabel.text = book.title
        infoLabel.text = book.info
    }
    
    func configureViews() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
    }
    
    func setConstraints() {
        coverImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView).inset(10)
            make.height.equalTo(100)
            make.width.equalTo(coverImageView.snp.height).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(contentView).inset(10)
            make.bottom.equalTo(coverImageView.snp.centerY)
            make.leading.equalTo(coverImageView.snp.trailing).offset(10)
            make.trailing.greaterThanOrEqualTo(contentView).inset(10)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.bottom.greaterThanOrEqualTo(contentView).inset(10)
            make.top.equalTo(coverImageView.snp.centerY)
            make.leading.equalTo(coverImageView.snp.trailing).offset(10)
            make.trailing.greaterThanOrEqualTo(contentView).inset(10)
        }
    }
}

