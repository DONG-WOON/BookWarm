//
//  ExploreViewController.swift
//  BookWarm
//
//  Created by 서동운 on 8/2/23.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var exploreBooksTableView: UITableView!
    @IBOutlet weak var recentlyReadBooksCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHeaderCollectionView()
        setTableView()
    }
    
    private func setHeaderCollectionView() {
        let headerNib = UINib(nibName: ExploreHeaderCollectionViewCell.identifier, bundle: nil)
        
        recentlyReadBooksCollectionView.register(headerNib, forCellWithReuseIdentifier: ExploreHeaderCollectionViewCell.identifier)
        recentlyReadBooksCollectionView.collectionViewLayout = flowLayoutConfiguration()
        recentlyReadBooksCollectionView.delegate = self
        recentlyReadBooksCollectionView.dataSource = self
    }
    
    private func setTableView() {
        let nib = UINib(nibName: ExploreTableViewCell.identifier, bundle: nil)
        
        exploreBooksTableView.register(nib, forCellReuseIdentifier: ExploreTableViewCell.identifier)
        exploreBooksTableView.dataSource = self
        exploreBooksTableView.delegate = self
        exploreBooksTableView.rowHeight = UITableView.automaticDimension
        exploreBooksTableView.separatorInset = .init(top: 0, left: 90, bottom: 0, right: 10)
    }
    
    
    private func flowLayoutConfiguration() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 7
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (5 * spacing)) / 4
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: cellWidth, height: 6/4 * cellWidth)
        flowLayout.minimumLineSpacing = spacing
        
        return flowLayout
    }
}

// MARK:  CollectionView

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreHeaderCollectionViewCell.identifier, for: indexPath) as! ExploreHeaderCollectionViewCell
        
        cell.update(with: books[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        let nav = UINavigationController(rootViewController: detailVC)
        
        nav.modalPresentationStyle = .fullScreen
        
        let dismissAction = UIAction(image: UIImage(systemName: "xmark")) { _ in
            self.dismiss(animated: true)
        }
        
        detailVC.navigationItem.leftBarButtonItem = UIBarButtonItem(primaryAction: dismissAction)
        
        detailVC.book = books[indexPath.row]
        
        present(nav, animated: true)
    }
}

// MARK:  TableView

extension ExploreViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.identifier, for: indexPath) as! ExploreTableViewCell
        
        cell.update(with: books[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        let nav = UINavigationController(rootViewController: detailVC)
        
        nav.modalPresentationStyle = .fullScreen
        
        let dismissAction = UIAction(image: UIImage(systemName: "xmark")) { _ in
            self.dismiss(animated: true)
        }
        
        detailVC.navigationItem.leftBarButtonItem = UIBarButtonItem(primaryAction: dismissAction)
        
        detailVC.book = books[indexPath.row]
        
        present(nav, animated: true)
    }
}
