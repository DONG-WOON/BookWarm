//
//  APIManager.swift
//  BookWarm
//
//  Created by 서동운 on 9/4/23.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    private init() { }
    
    func requestKakaoBookSearch(search: String, size: Int = 15, page: Int, onSuccess: @escaping ([Book]) -> Void, onFailure: @escaping (Error?) -> Void) {
        let query = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)&size=\(size)")!
        var request = URLRequest(url: url)
        request.setValue(APIKey.kakao, forHTTPHeaderField: "Authorization")
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                onFailure(error)
                return
            }
            guard let status = (response as? HTTPURLResponse)?.statusCode,
                  (200..<300).contains(status) else {
                onFailure(error)
                return
            }
            do {
                guard let data else { return }
                let result = try JSONDecoder().decode(Response.self, from: data)
                onSuccess(result.documents)
            } catch {
                onFailure(error)
            }
        }.resume()
    }
}
