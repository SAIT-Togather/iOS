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
    var photos: [MemoryPhoto]
    var category: MemoryCategory?
    var isLiked: Bool

    // MARK: - Computed Properties

    var representativePhoto: MemoryPhoto? {
        photos.first
    }

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        title: String,
        date: Date,
        photos: [MemoryPhoto],
        category: MemoryCategory? = nil,
        isLiked: Bool = false
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.photos = photos
        self.category = category
        self.isLiked = isLiked
    }
    
}
