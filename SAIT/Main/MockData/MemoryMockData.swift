//
//  MemoryMockData.swift
//  SAIT
//
//  Created by 이머영 on 11/26/26.
//

import Foundation

enum MemoryMockData {
    
    // MARK: - Memories
    
    static let memories: [CoupleMemory] = [
        CoupleMemory(
            title: "바다 여행",
            date: makeDate(year: 2026, month: 11, day: 10),
            photos: [
                MemoryPhoto(source: .asset(name: "memory_sample_1"))
            ],
            category: .travel
        ),
        CoupleMemory(
            title: "카페 데이트",
            date: makeDate(year: 2026, month: 11, day: 3),
            photos: [
                MemoryPhoto(source: .asset(name: "memory_sample_1"))
            ],
            category: .date,
            isLiked: true
        ),
        CoupleMemory(
            title: "야경 데이트",
            date: makeDate(year: 2026, month: 10, day: 25),
            photos: [
                MemoryPhoto(source: .asset(name: "memory_sample_1"))
            ],
            category: .date
        ),
        CoupleMemory(
            title: "우리의 기념일",
            date: makeDate(year: 2026, month: 10, day: 14),
            photos: [
                MemoryPhoto(source: .asset(name: "memory_sample_1"))
            ],
            category: .anniversary
        )
    ]
    
}

// MARK: Helpers

private extension MemoryMockData {

    static func makeDate(
        year: Int,
        month: Int,
        day: Int
    ) -> Date {

        guard let date = Calendar.current.date(
            from: DateComponents(
                year: year,
                month: month,
                day: day
            )
        ) else {
            preconditionFailure("잘못된 Mock 날짜입니다.")
        }

        return date
    }
}
