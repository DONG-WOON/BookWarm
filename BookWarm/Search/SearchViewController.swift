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

    var searchedBooks: [Book] = [] {
        didSet {
            bookTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bookSearchBar.delegate = self
        bookSearchBar.returnKeyType = .search
        
        bookTableView.dataSource = self
        bookTableView.delegate = self

        let nib = UINib(nibName: ExploreTableViewCell.identifier, bundle: nil)
        bookTableView.register(nib, forCellReuseIdentifier: ExploreTableViewCell.identifier)
    }
    
    private func searchBook(search: String) {
        let query = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.kakao]
        
        AF.request(url, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let books = JSON(value)
                let bookList = (0...6).map { i in
                    let author = books["documents"][i]["authors"].stringValue
                    let contents = books["documents"][i]["contents"].stringValue
                    let thumbnailURL = books["documents"][i]["thumbnail"].stringValue
                    let title = books["documents"][i]["title"].stringValue
                    
                    return Book(title: title, releaseDate: "", runtime: 0, overview: contents, rate: 0, isFavorite: false, thumbnailURL: thumbnailURL)
                }
                self.searchedBooks = bookList
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchBook(search: text)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       
        guard let text = searchBar.text else { return }
        searchBook(search: text)
    }
}

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
