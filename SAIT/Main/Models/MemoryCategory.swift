//
//  MemoryCategory.swift
//  SAIT
//
//  Created by 이머영 on 11/25/26.
//

import Foundation

enum MemoryCategory: String, CaseIterable, Identifiable {
    case date
    case travel
    case anniversary
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .date:
            return "데이트"
        case .travel:
            return "여행"
        case .anniversary:
            return "기념일"
        }
    }
}
