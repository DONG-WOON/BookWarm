//
//  MainViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    private var myBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMyBookData()
        configureCollectionView()
    }
   
    private func loadMyBookData() {
        // 추후 구현과제 - 내가 저장한 책 불러오기
    }
}

// MARK: - CollectionView

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myBooks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()
        }
        
        let book = myBooks[indexPath.item]
        cell.book = book
        
        cell.favoriteButtonAction = {
            self.myBooks[indexPath.item].isFavorite.toggle()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        
        detailVC.book = myBooks[indexPath.item]
        detailVC.action = .edit
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: Configure UI

extension MainViewController {
 
    private func configureCollectionView() {
        let nib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = DefaultCollectionViewFlowLayout(cellCount: 2)
    }
}
