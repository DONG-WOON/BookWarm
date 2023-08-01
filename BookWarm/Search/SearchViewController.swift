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
    
    var filteredBooks: [Book] = books.shuffled().dropLast(3)

    override func viewDidLoad() {
        super.viewDidLoad()

        bookSearchBar.delegate = self
        bookTableView.dataSource = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredBooks = books.filter { $0.title.contains(searchText) }
            bookTableView.reloadData()
        } else {
            filteredBooks = books.shuffled().dropLast(3)
            bookTableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = filteredBooks[indexPath.row].title
        configuration.image = UIImage(named: filteredBooks[indexPath.row].title)?.preparingThumbnail(of: CGSize(width: 40, height: 60))
        configuration.secondaryText = "\(filteredBooks[indexPath.row].rate)점"
        
        cell.contentConfiguration = configuration
        
        return cell
    }
}
