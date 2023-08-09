//
//  MainViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    private var myBooks: [Book] = []
    private lazy var filteredBooks: [Book] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMyBookData()
        configureSearchBar()
        configureCollectionView()
    }
    
    
    
    @objc func favoriteButtonDidTapped(_ sender: UIButton) {
        let index = sender.tag
        filteredBooks[index].isFavorite.toggle()
    }
    
    private func loadMyBookData() {
        // 추후 구현과제 - 내가 저장한 책 불러오기
    }
}

// MARK: - CollectionView

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        let book = filteredBooks[indexPath.item]
        
        // 셀의 컬러를 book의 내부에서 갖고 있는게 옳바른 방식인가?
        cell.backgroundColor = .getColor(rgb: book.backgroundColor)
        cell.rounded(cornerRadius: 10, isShadowBackground: true)
        cell.update(with: book)
        
        cell.favoriteButton.tag = indexPath.item
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonDidTapped), for: .touchUpInside)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        
        detailVC.book = filteredBooks[indexPath.item]
        detailVC.action = .edit
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Search

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredBooks = myBooks.filter { $0.title.contains(searchText) }
        } else {
            filteredBooks = myBooks
        }
    }
}

// MARK: Configure UI

extension MainViewController {
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "도서 검색"
        
        navigationItem.titleView = searchBar
    }
    private func configureCollectionView() {
        let nib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = DefaultCollectionViewFlowLayout(cellCount: 2)
    }
}
