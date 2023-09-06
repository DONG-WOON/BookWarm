//
//  BookTable.swift
//  BookWarm
//
//  Created by 서동운 on 9/5/23.
//

import Foundation
import RealmSwift

class BookTable: Object {
    @Persisted(primaryKey: true) var isbn: String
    
    @Persisted var title: String
    @Persisted var releaseDate: String?
    @Persisted var runtime: Int?
    @Persisted var overview: String?
    @Persisted var isFavorite: Bool
    @Persisted var thumbnailURL: String?
    @Persisted var backgroundColor: ColorTable?
    @Persisted var memo: String?
    // automatically, but must update the schema version.
    @Persisted var publisher: String?
    
    convenience init(book: Book) {
        self.init()
        
        self.isbn = book.isbn
        self.title = book.title
        self.releaseDate = book.datetime
        self.runtime = nil
        self.overview = book.overview
        self.isFavorite = book.isFavorite
        self.thumbnailURL = book.thumbnail
        self.isFavorite = book.isFavorite
        self.backgroundColor = book.background?.toColorTable()
        self.memo = book.memo
        self.publisher = book.publisher
    }
}

class ColorTable: Object {
    @Persisted var red: Float
    @Persisted var green: Float
    @Persisted var blue: Float
    @Persisted var alpha: Float

    convenience init(red: Float, green: Float, blue: Float, alpha: Float) {
        self.init()
        
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    func toColor() -> Color {
        return Color(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}
