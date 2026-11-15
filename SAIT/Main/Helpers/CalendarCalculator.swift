//
//  CalendarCalculator.swift
//  SAIT
//
//  Created by 이머영 on 11/15/26.
//

import Foundation

enum CalendarCalculator {
    
    // MARK: - Calendar
    
    private static var calendar: Calendar {
        Calendar.current
    }
    
    // MARK: - Month Start
    
    static func startOfMonth(for date: Date) -> Date {
        calendar.dateInterval(
            of: .month,
            for: date
        )?.start ?? date
    }
    
    static func addingMonths(
        _ value: Int,
        to date: Date
    ) -> Date {
        let monthStart = startOfMonth(for: date)
        
        return calendar.date(
            byAdding: .month,
            value: value,
            to: monthStart
        ) ?? monthStart
    }
    
    // MARK: - Month Title
    
    static func monthTitle(for date: Date) -> String {
        date.formatted(
            .dateTime
                .year()
                .month(.wide)
                .locale(Locale(identifier: "ko_KR"))
        )
    }
    
    // MARK: - Weekday Symbols
    
    static let weekdaySymbols = [
        "일", "월", "화", "수", "목", "금", "토"
    ]
    
    // MARK: - Days In Month
    
    static func numberOfDays(in month: Date) -> Int {
        calendar.range(
            of: .day,
            in: .month,
            for: month
        )?.count ?? 0
    }
    
    // MARK: - First Weekday Offset
    
    static func firstWeekdayOffset(for month: Date) -> Int {
        let monthStart = startOfMonth(for: month)
        
        let weekday = calendar.component(
            .weekday,
            from: monthStart
        )
        
        // Calendar의 weekday: 일요일 = 1, 토요일 = 7
        return (weekday - 1 + 7) % 7
    }
    
    // MARK: - Month Days
    
    static func daysInMonth(for month: Date) -> [Int?] {
        let offset = firstWeekdayOffset(for: month)
        let numberOfDays = numberOfDays(in: month)
        
        let emptyDays = Array<Int?>(
            repeating: nil,
            count: offset
        )
        
        let days = (1...numberOfDays).map { Optional($0) }
        
        return emptyDays + days
    }
    
    // MARK: - Date Helpers
    
    static func date(
        for day: Int,
        in month: Date
    ) -> Date? {
        calendar.date(
            byAdding: .day,
            value: day - 1,
            to: startOfMonth(for: month)
        )
    }
    
    static func isSameDay(
        _ lhs: Date,
        _ rhs: Date
    ) -> Bool {
        calendar.isDate(lhs, inSameDayAs: rhs)
    }
    
    static func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
    
}
