//
//  DateCalculator.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import Foundation

enum DateCalculator {
    /// 시작일을 1일째로 계산합니다.
    /// 시작일이 미래라면 nil을 반환합니다.
    static func daysTogether(
        from startDate: Date,
        to today: Date = Date(),
        calendar: Calendar = .current
    ) -> Int? {
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: today)

        guard start <= end else {
            return nil
        }

        let days = calendar.dateComponents(
            [.day],
            from: start,
            to: end
        ).day ?? 0

        return days + 1
    }

    /// 오늘이면 0, 미래면 양수, 과거면 음수를 반환합니다.
    static func remainingDays(
        until date: Date,
        from today: Date = Date(),
        calendar: Calendar = .current
    ) -> Int {
        let start = calendar.startOfDay(for: today)
        let target = calendar.startOfDay(for: date)

        return calendar.dateComponents(
            [.day],
            from: start,
            to: target
        ).day ?? 0
    }
    
    static func nextAnniversary(
        from startDate: Date,
        today: Date = Date(),
        calendar: Calendar = .current
    ) -> Anniversary? {
        guard let days = daysTogether(
            from: startDate,
            to: today,
            calendar: calendar
        ) else {
            return nil
        }

        // 기념일 당일에는 해당 기념일을 유지합니다.
        let nextDays = ((days + 99) / 100) * 100

        guard let anniversaryDate = calendar.date(
            byAdding: .day,
            value: nextDays - 1,
            to: calendar.startOfDay(for: startDate)
        ) else {
            return nil
        }

        return Anniversary(
            days: nextDays,
            date: anniversaryDate,
            remainingDays: remainingDays(
                until: anniversaryDate,
                from: today,
                calendar: calendar
            )
        )
    }
    
}

struct Anniversary {
    let days: Int
    let date: Date
    let remainingDays: Int
}
