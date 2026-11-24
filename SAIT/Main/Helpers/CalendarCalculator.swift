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
    
    static func date(
        bySettingHour hour: Int,
        minute: Int,
        for date: Date
    ) -> Date {
        let calendar = Calendar.current
        
        return calendar.date(
            bySettingHour: hour,
            minute: minute,
            second: 0,
            of: date
        ) ?? date
    }
    
    // MARK: Exist Schedule
    
    static func scheduledDates(
        from schedules: [CoupleSchedule]
    ) -> Set<Date> {
        /// Array가 아닌 Set을 사용하는 이유
        /// - 일정의 존재 여부만 확인하면 되기 때문
        /// - Set의 contains( )는 평균 O(1)의 시간 복잡도를 가지므로 날짜 셀마다 전체 일정 배열을 탐색하는 것보다 효율적
        Set(
            schedules.map {
                /// Date에는 날짜뿐만 아니라 시간 정보도 포함되어 있기 때문에 날짜의 시작 시각으로 통일하기 위해 startOfDay(for: ) 사용
                calendar.startOfDay(for: $0.date)
            }
        )
    }
    
    static func hasSchedule(
        on date: Date,
        in scheduledDates: Set<Date>
    ) -> Bool {
        scheduledDates.contains(
            calendar.startOfDay(for: date)
        )
    }
    
}
