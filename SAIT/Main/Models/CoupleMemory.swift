//
//  CoupleMemory.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import Foundation

struct CoupleMemory: Identifiable {
    
    // MARK: - Properties
    
    let id: UUID
    var title: String
    var date: Date
    var imageName: String
    var category: MemoryCategory?
    var isLiked: Bool
    
    // MARK: - Initializer
    
    init(
        id: UUID = UUID(),
        title: String,
        date: Date,
        imageName: String,
        category: MemoryCategory? = nil,
        isLiked: Bool = false
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.imageName = imageName
        self.category = category
        self.isLiked = isLiked
    }
    
}
