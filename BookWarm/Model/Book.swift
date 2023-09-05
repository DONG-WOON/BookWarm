//
//  book.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import Foundation

struct Response: Codable {
    var meta: Meta
    var documents: [Book]
}

struct Meta: Codable {
    var isEnd: Bool?
    
    enum codingKeys: String, CodingKey {
        case isEnd = "is_end"
    }
}

struct Book: Codable {
    
    let authors: [String]?
    let overview, datetime: String?
    let isbn: String
    let price: Int?
    let publisher: String?
    let salePrice: Int?
    let thumbnail: String?
    let title: String
    let url: String?
    
    var background: Color?
    
    enum CodingKeys: String, CodingKey {
        case authors
        case overview = "contents"
        case datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case thumbnail, title, url
    }
    
    internal init(authors: [String]? = nil, overview: String? = nil, datetime: String? = nil, isbn: String = String(), price: Int? = nil, publisher: String? = nil, salePrice: Int? = nil, thumbnail: String? = nil, title: String = String(), url: String? = nil, background: Color = Color()) {
        self.authors = authors
        self.overview = overview
        self.datetime = datetime
        self.isbn = isbn
        self.price = price
        self.publisher = publisher
        self.salePrice = salePrice
        self.thumbnail = thumbnail
        self.title = title
        self.url = url
        self.background = background
    }
    
    init(table: BookTable) {
        self.authors = nil
        self.overview = table.overview
        self.datetime = table.releaseDate
        self.isbn = table.isbn
        self.price = nil
        self.publisher = nil
        self.salePrice = nil
        self.thumbnail = table.thumbnailURL
        self.title = table.title
        self.url = nil
        self.background = table.backgroundColorTable?.toColor()
    }
}

struct Color: Codable {
    
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    
    init(red: CGFloat = .random(in: 0...1), green: CGFloat = .random(in: 0...1), blue: CGFloat = .random(in: 0...1), alpha: CGFloat = 0.7) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    func toColorTable() -> ColorTable {
        return ColorTable(red: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
    }
}
