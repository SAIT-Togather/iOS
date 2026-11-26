//
//  MemoryMonthSection.swift
//  SAIT
//
//  Created by 이머영 on 11/26/26.
//

import Foundation

struct MemoryMonthSection: Identifiable {
    
    // MARK: - Properties
    
    let month: Date
    let memories: [CoupleMemory]
    
    var id: Date {
        month
    }
    
}
