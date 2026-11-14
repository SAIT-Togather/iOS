//
//  CoupleMemory.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import Foundation

struct CoupleMemory: Identifiable {
    let id: UUID
    let title: String
    let date: Date
    let imageName: String
    
    init(
        id: UUID = UUID(),
        title: String,
        date: Date,
        imageName: String
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.imageName = imageName
    }
}
