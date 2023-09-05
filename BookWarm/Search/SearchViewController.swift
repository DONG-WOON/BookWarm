//
//  SearchViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//
//
import UIKit
import Alamofire

class SearchViewController: UIViewController {

    let bookSearchBar = UISearchBar()
    let bookTableView = UITableView()
    
    var searchedBooks: [Book] = []
    var searchText = String()
    var page = 1
    var isPageEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setSearchBar()
        
        configureViews()
        setConstraints()
    }
    
    private func searchBook(search: String, size: Int = 15, page: Int) {
        DispatchQueue.global().async {
            APIManager.shared.requestKakaoBookSearch(search: search, page: page) { books in
                DispatchQueue.main.async {
                    self.searchedBooks.append(contentsOf: books)
                    self.bookTableView.reloadData()
                }
            } onFailure: { error in
                self.showErrorMessage(message: error?.localizedDescription)
            }
        }
    }
}

extension SearchViewController {
    func configureViews() {
        view.addSubview(bookSearchBar)
        view.addSubview(bookTableView)
    }
    func setConstraints() {
        bookSearchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        bookTableView.snp.makeConstraints { make in
            make.top.equalTo(bookSearchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.keyboardLayoutGuide)
        }
    }
}

// MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
    
    func setSearchBar() {
        bookSearchBar.delegate = self
        bookSearchBar.returnKeyType = .search
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchedBooks.removeAll()
        searchText = text
        isPageEnd = false
        page = 1
        searchBook(search: searchText, page: page)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchedBooks.removeAll()
        searchText = text
        isPageEnd = false
        page = 1
        searchBook(search: searchText, page: page)
    }
}

// MARK: - TableView DataSource, Delegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setTableView() {
        bookTableView.rowHeight = UITableView.automaticDimension
        bookTableView.dataSource = self
        bookTableView.delegate = self
        bookTableView.prefetchDataSource = self
        
        bookTableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as! SearchViewCell
        
        cell.update(with: searchedBooks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        detailVC.book = searchedBooks[indexPath.item]
        
        present(detailVC, animated: true)
    }
}

// MARK: - Prefetching

extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row == searchedBooks.count - 1 }) && !isPageEnd {
            page += 1
            searchBook(search: searchText, page: page)
        }
    }
}
