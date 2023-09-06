//
//  Repository.swift
//  BookWarm
//
//  Created by 서동운 on 9/6/23.
//

//import Foundation
import RealmSwift
import Realm

public protocol Repository {
    associatedtype T: Object
    
    func fetchItems(_ item: T.Type) -> Results<T>
    func fetchItem(_ item: T.Type, forPrimaryKeyPath: String) -> T?
    func createItem(_ item: T) throws
    func updateItem(_ item: T, update: (T) -> Void) throws
    func deleteItem(_ item: Results<T>)
}

enum RepositoryError: Error {
    case fetchError
    case saveError
    case itemIsNil
    case itemIsInvalid
    case updateError
}

final class BookRepository<T: BookTable>: Repository {
    
    private let realm = try! Realm()
    
    func fetchItems(_ item: T.Type) -> Results<T> {
        let result = realm.objects(item)
        return result
    }
    
    func fetchItem(_ item: T.Type, forPrimaryKeyPath: String) -> T? {
        let result = realm.object(ofType: item, forPrimaryKey: forPrimaryKeyPath)
        return result
    }
    
    func createItem(_ item: T) throws {
        do {
            try realm.write{
                realm.add(item)
            }
        } catch {
            throw RepositoryError.saveError
        }
    }
    
    func updateItem(_ item: T, update: (T) -> Void) throws {
        do {
            try realm.write{
                update(item)
                realm.add(item, update: .modified)
            }
        } catch {
            throw RepositoryError.updateError
        }
    }
    
    func deleteItem(_ item: Results<T>) {
        realm.delete(item)
    }
    
    func fetchSortedItem<U>(by keyPath: KeyPath<T, U>, ascending: Bool = true) -> Results<T> where U: _HasPersistedType, U.PersistedType : SortableType {
        let data = realm.objects(T.self).sorted(by: keyPath, ascending: ascending)
        return data
    }
    
    func fetchFilter(_ isIncluded: (Query<T>) -> Query<Bool>) -> Results<T> {
        let data = realm.objects(T.self).where { isIncluded($0) }
        return data
    }
}

