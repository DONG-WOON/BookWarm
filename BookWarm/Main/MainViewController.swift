//
//  MainViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: DefaultCollectionViewFlowLayout(cellCount: 2))
    
    private var myBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        setConstraints()
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMyBookData()
        tabBarController?.tabBar.isHidden = false
    }
   
    private func loadMyBookData() {
        let realm = try! Realm()
        let result = realm.objects(BookTable.self)
        
        myBooks = result.map { Book(table: $0) }
        collectionView.reloadData()
    }
}

extension MainViewController {
    func configureViews() {
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - CollectionView

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()
        }
        
        cell.update(book: myBooks[indexPath.item])
        
        cell.favoriteButtonAction = {
            self.myBooks[indexPath.item].isFavorite.toggle()
            collectionView.reloadItems(at: [indexPath])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
