//
//  CalendarScheduleListView.swift
//  SAIT
//
//  Created by 이머영 on 11/15/26.
//

import SwiftUI

struct CalendarScheduleListView: View {
    
    // MARK: - Properties
    
    let selectedDate: Date
    let schedules: [CoupleSchedule]
    
    // MARK: - Body
    
    var body: some View {
        SAITCard {
            VStack(alignment: .leading, spacing: 20) {
                
                headerView
                
                if schedules.isEmpty {
                    emptyScheduleView
                } else {
                    scheduleListView
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    
}

// MARK: - Header

private extension CalendarScheduleListView {
    
    var headerView: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(dateTitle)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(SAITColors.primaryText)
                
                Text("우리의 일정 \(schedules.count)개")
                    .font(.system(size: 12))
                    .foregroundStyle(SAITColors.secondaryText)
            }
            
            Spacer()
            
            Image(systemName: "calendar")
                .font(.system(size: 18))
                .foregroundStyle(SAITColors.primary)
                .frame(width: 40, height: 40)
                .background(SAITColors.lightBlue)
                .clipShape(Circle())
        }
    }
    
    var dateTitle: String {
        selectedDate.formatted(
            .dateTime
                .month(.twoDigits)
                .day()
                .weekday(.wide)
                .locale(Locale(identifier: "ko_KR"))
        )
    }
    
}

// MARK: - Schedule List

private extension CalendarScheduleListView {
    
    var scheduleListView: some View {
        VStack(spacing: 16) {
            ForEach(schedules) { schedule in
                
                CalendarScheduleRow(
                    schedule: schedule
                )
            }
        }
    }
    
}

// MARK: - Empty State

private extension CalendarScheduleListView {
    
    var emptyScheduleView: some View {
        VStack(spacing: 12) {
            
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 30))
                .foregroundStyle(SAITColors.primary)
            
            Text("등록된 일정이 없어요")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(SAITColors.primaryText)
            
            Text("새로운 추억을 위한 일정을 추가해보세요.")
                .font(.system(size: 12))
                .foregroundStyle(SAITColors.secondaryText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
    }
    
}

// MARK: - Preview

#Preview {
    CalendarScheduleListView(
        selectedDate: Date(),
        schedules: CalendarMockData.schedules.filter {
            CalendarCalculator.isSameDay(
                $0.date,
                Date()
            )
        }
    )
    .padding(20)
    .background(SAITColors.background)
}
