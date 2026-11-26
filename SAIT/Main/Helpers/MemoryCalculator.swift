//
//  MemoryCalculator.swift
//  SAIT
//
//  Created by 이머영 on 11/26/26.
//

import Foundation

enum MemoryCalculator {
    
    // MARK: - Month Sections
    
    static func monthSections(
        from memories: [CoupleMemory],
        calendar: Calendar = .current
    ) -> [MemoryMonthSection] {
        
        var groupedMemories: [Date: [CoupleMemory]] = [:]
        
        for memory in memories {
            guard let month = calendar.dateInterval(
                of: .month,
                for: memory.date
            )?.start else {
                continue
            }
            
            groupedMemories[month, default: []].append(memory)
        }
        
        return groupedMemories.map { month, memories in
            MemoryMonthSection(
                month: month,
                memories: memories.sorted {
                    $0.date > $1.date
                }
            )
        }
        .sorted {
            $0.month > $1.month
        }
    }
    
}
