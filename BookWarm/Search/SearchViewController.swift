//
//  SearchViewController.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//
//
import UIKit
import Alamofire
import SwiftyJSON


class SearchViewController: UIViewController {

    @IBOutlet weak var bookSearchBar: UISearchBar!
    @IBOutlet weak var bookTableView: UITableView!

    var searchedBooks: [Book] = []
    var searchText = String()
    var page = 1
    var isPageEnd = false

    override func viewDidLoad() {
        super.viewDidLoad()

        bookSearchBar.delegate = self
        bookSearchBar.returnKeyType = .search
        
        bookTableView.dataSource = self
        bookTableView.delegate = self
        bookTableView.prefetchDataSource = self

        let nib = UINib(nibName: ExploreTableViewCell.identifier, bundle: nil)
        bookTableView.register(nib, forCellReuseIdentifier: ExploreTableViewCell.identifier)
    }
    
    private func searchBook(search: String, size: Int = 15, page: Int) {
        let query = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)&size=\(size)"
        let header: HTTPHeaders = ["Authorization": APIKey.kakao]
        
        AF.request(url, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.isPageEnd  = json["meta"]["is_end"].boolValue
               
                let documents = json["documents"].arrayValue
                let bookList = documents.map { book in
                    let author = book["authors"].stringValue
                    let contents = book["contents"].stringValue
                    let thumbnailURL = book["thumbnail"].stringValue
                    let title = book["title"].stringValue
                    
                    return Book(title: title, releaseDate: "", runtime: 0, overview: contents, rate: 0, isFavorite: false, thumbnailURL: thumbnailURL)
                }
                self.searchedBooks.append(contentsOf: bookList)
                self.bookTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
    
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.identifier, for: indexPath) as! ExploreTableViewCell

        cell.update(with: searchedBooks[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController

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
