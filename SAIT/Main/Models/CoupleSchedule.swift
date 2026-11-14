//
//  CoupleSchedule.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import Foundation

struct CoupleSchedule: Identifiable {
    let id: UUID
    let title: String
    let date: Date
    
    init(
        id: UUID = UUID(),
        title: String,
        date: Date
    ) {
        self.id = id
        self.title = title
        self.date = date
    }
    
}
