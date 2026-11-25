//
//  ScheduleStore.swift
//  SAIT
//
//  Created by 이머영 on 11/24/26.
//

import Foundation
import Combine

/// 기존 CalendarView에 구현했던 일정 관리 로직을 공통 저장소로 옮길 수 있도록 구성

/// [class로 구현한 이유]
/// - 홈과 캘린더가 동일한 인스턴스를 참조해야 하기 때문
/// - 현재 저장소를 확장할 계획이 없으므로 다른 클래스가 상속하지 못하도록 final 키워드로 제한
/// [ObservableObject]
/// - SwiftUI에서 객체의 변경 사항을 관찰할 수 있도록 하는 프로토콜
/// - 일반적인 클래스의 프로퍼티를 변경한다고 해서 SwiftUI 화면이 자동으로 갱신되지 않음
/// - ObservableObject와 @Published를 함께 사용하면 객체를 관찰하는 SwiftUI View에 변경 사항을 전달할 수 있음
@MainActor
final class ScheduleStore: ObservableObject {
    
    // MARK: - Properties
    
    /// [Published]
    /// - 해당 프로퍼티의 변경 사항을 발행하는 Property Wrapper
    /// - 기존 @State를 사용했을 때와 유사하게 UI가 자동으로 갱신되지만, 이번에는 View 외부의 객체에서 상태를 관리한다는 차이가 있음
    /// [private(set)]
    /// - 외부에서 읽을 수 있지만 직접 변경할 수 없도록 제한 (읽을 수는 있다는 점이 private와 차이점)
    @Published private(set) var schedules: [CoupleSchedule]
    
    // MARK: - Initializer
    
    init(schedules: [CoupleSchedule] = []) {
        self.schedules = schedules
    }
    
}

// MARK: - CRUD

extension ScheduleStore {
    
    func addSchedule(_ schedule: CoupleSchedule) {
        guard !schedules.contains(where: {
            $0.id == schedule.id
        }) else {
            return
        }
        
        schedules.append(schedule)
    }
    
    func updateSchedule(_ updatedSchedule: CoupleSchedule) {
        guard let index = schedules.firstIndex(where: {
            $0.id == updatedSchedule.id
        }) else {
            return
        }
        
        schedules[index] = updatedSchedule
    }
    
    func deleteSchedule(_ schedule: CoupleSchedule) {
        schedules.removeAll {
            $0.id == schedule.id
        }
    }
    
}

// MARK: - Query

extension ScheduleStore {
    
    func schedules(on date: Date) -> [CoupleSchedule] {
        schedules
            .filter {
                CalendarCalculator.isSameDay($0.date, date)
            }
            .sorted {
                $0.date < $1.date
            }
    }
    
    func nextSchedule(from date: Date = Date()) -> CoupleSchedule? {
        schedules
            .filter {
                $0.date >= date
            }
            .min {
                $0.date < $1.date
            }
    }
    
    var scheduledDates: Set<Date> {
        CalendarCalculator.scheduledDates(
            from: schedules
        )
    }
    
}
