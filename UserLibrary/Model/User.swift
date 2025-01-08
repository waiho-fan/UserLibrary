//
//  User.swift
//  UserLibrary
//
//  Created by Gary on 8/1/2025.
//

import Foundation
import SwiftData
import SwiftUI

struct User: Identifiable, Codable {
    var id: UUID
    var name: String
    var photoData: Data
    
    var photoImage: Image? {
        if let uiImage = UIImage(data: photoData) {
            return Image(uiImage: uiImage)
        }

        return Image(systemName: "person.circle.fill")
    }
    
    static var mockImageData: Data {
        let configuration = UIImage.SymbolConfiguration(pointSize: 100)
        let uiImage = UIImage(systemName: "person.circle.fill", withConfiguration: configuration)
        return uiImage?.pngData() ?? Data()
    }
    
    init(name: String, photoData: Data) {
        self.id = UUID()
        self.name = name
        self.photoData = photoData
    }
}
