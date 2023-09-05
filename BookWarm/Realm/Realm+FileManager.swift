//
//  Realm+FileManager.swift
//  BookWarm
//
//  Created by 서동운 on 9/5/23.
//

import RealmSwift
import Foundation
import UIKit

enum FileManagerError: Error {
    case invalidDirectory
    case fileIsNil
    case jpegDataError
    case fileSaveError
    case fileIsNotExist
}

extension Realm {
  
    func saveImage(path fileName: String, image: UIImage?) throws {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { throw FileManagerError.invalidDirectory }
        let fileURL = documentDirectory.appending(path: fileName)
        guard let image = image else { return }
        guard let data = image.jpegData(compressionQuality: 0.5) else { throw FileManagerError.jpegDataError
        }
        do {
            try data.write(to: fileURL)
        } catch {
            throw FileManagerError.fileSaveError
        }
    }
    
    func loadImageFromDocument(fileName: String) throws -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { throw FileManagerError.invalidDirectory  }
        let fileURL = documentDirectory.appending(path: fileName)
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            throw FileManagerError.fileIsNil
        }
    }
    
    func deleteImageFromDocument(fileName: String) throws {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { throw FileManagerError.invalidDirectory }
        let fileURL = documentDirectory.appending(path: fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                throw error
            }
        } else {
            return
        }
    }
}
