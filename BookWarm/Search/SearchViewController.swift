//
//  SearchViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var bookSearchBar: UISearchBar!
    @IBOutlet weak var bookTableView: UITableView!
    
    var filteredBooks: [Book] = books.shuffled()

    override func viewDidLoad() {
        super.viewDidLoad()

        bookSearchBar.delegate = self
        bookTableView.dataSource = self
        bookTableView.delegate = self
        
        let nib = UINib(nibName: ExploreTableViewCell.identifier, bundle: nil)
        bookTableView.register(nib, forCellReuseIdentifier: ExploreTableViewCell.identifier)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredBooks = books.filter { $0.title.contains(searchText) }
        } else {
            filteredBooks = books.shuffled()
        }
        
        bookTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.identifier, for: indexPath) as! ExploreTableViewCell
        
        cell.update(with: filteredBooks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        detailVC.book = filteredBooks[indexPath.item]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
