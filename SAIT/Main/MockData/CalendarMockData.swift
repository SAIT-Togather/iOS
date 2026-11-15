//
//  CalendarMockData.swift
//  SAIT
//
//  Created by 이머영 on 11/15/26.
//

import Foundation

enum CalendarMockData {

    static var schedules: [CoupleSchedule] {
        let calendar = Calendar.current

        let today = calendar.startOfDay(for: Date())

        guard let tomorrow = calendar.date(
            byAdding: .day,
            value: 1,
            to: today
        ),
        let threeDaysLater = calendar.date(
            byAdding: .day,
            value: 3,
            to: today
        ) else {
            return []
        }

        return [
            CoupleSchedule(
                title: "카페 데이트",
                date: today
            ),
            CoupleSchedule(
                title: "저녁 식사",
                date: today
            ),
            CoupleSchedule(
                title: "영화 데이트",
                date: tomorrow
            ),
            CoupleSchedule(
                title: "주말 나들이",
                date: threeDaysLater
            )
        ]
    }
    
}
