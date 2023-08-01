//
//  MainViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    var bookList = books

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = DefaultCollectionViewFlowLayout()
    }
    @IBAction func serchBarButtonDidTapped(_ sender: UIBarButtonItem) {
        let searchVC = storyboard?.instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as! SearchViewController
        let navigationController = UINavigationController(rootViewController: searchVC)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        let dismissAction = UIAction { _ in
            self.dismiss(animated: true)
        }

        searchVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), primaryAction: dismissAction)
        searchVC.title = "검색 화면"
        
        present(navigationController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .random()
        cell.rounded(cornerRadius: 10, isShadowBackground: true)
        cell.update(with: bookList[indexPath.item])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        
        detailVC.bookTitle = bookList[indexPath.item].title
        detailVC.bookRate = bookList[indexPath.item].rate
        detailVC.bookOverView = bookList[indexPath.item].overview
        detailVC.coverImage = UIImage(named: bookList[indexPath.item].title)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
