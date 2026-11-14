//
//  HomeMockData.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import Foundation

enum HomeMockData {
    
//    static var relationshipStartDate: Date? = nil
    
    static var relationshipStartDate: Date? {
        Calendar.current.date(
            from: DateComponents(
                year: 2025,
                month: 3,
                day: 14
            )
        )
    }
    
//    static var schedules: [CoupleSchedule] = []
    
    static var schedules: [CoupleSchedule] {
        guard let date = Calendar.current.date(
            byAdding: .day,
            value: 3,
            to: Date()
        ) else {
            return []
        }

        return [
            CoupleSchedule(
                title: "주말 영화 데이트",
                date: date
            )
        ]
    }

    static var memories: [CoupleMemory] {
        []
    }
    
    /*static var memories: [CoupleMemory] = [
        CoupleMemory(
            title: "바다 여행",
            date: Calendar.current.date(
                from: DateComponents(
                    year: 2026,
                    month: 11,
                    day: 10
                )
            )!,
            imageName: "memory_sample_1"
        ),
        CoupleMemory(
            title: "카페 데이트",
            date: Calendar.current.date(
                from: DateComponents(
                    year: 2026,
                    month: 11,
                    day: 3
                )
            )!,
            imageName: "memory_sample_2"
        ),
        CoupleMemory(
            title: "야경 데이트",
            date: Calendar.current.date(
                from: DateComponents(
                    year: 2026,
                    month: 10,
                    day: 25
                )
            )!,
            imageName: "memory_sample_3"
        )
    ]*/
    
}
