//
//  MainViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    lazy var filteredBooks: [Book] = books {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureCollectionView()
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "도서 검색"
        
        navigationItem.titleView = searchBar
    }
    func configureCollectionView() {
        let nib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = DefaultCollectionViewFlowLayout(cellCount: 2)
    }
    
    @objc func favoriteButtonDidTapped(_ sender: UIButton) {
        let index = sender.tag
        filteredBooks[index].isFavorite.toggle()
    }
}

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


extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredBooks = books.filter { $0.title.contains(searchText) }
        } else {
            filteredBooks = books
        }
    }
}
