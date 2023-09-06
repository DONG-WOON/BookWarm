//
//  User.swift
//  BookWarm
//
//  Created by 서동운 on 9/6/23.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
