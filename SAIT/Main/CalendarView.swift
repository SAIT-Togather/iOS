//
//  CalendarView.swift
//  SAIT
//
//  Created by 이머영 on 11/12/26.
//

import SwiftUI

struct CalendarView: View {
    
    // MARK: - Properties
    
    @State private var displayedMonth = CalendarCalculator.startOfMonth(
        for: Date()
    )
    
    @State private var selectedDate = Date()
    
    @State private var schedules = CalendarMockData.schedules
    private var selectedDateSchedules: [CoupleSchedule] {
        schedules
            .filter {
                CalendarCalculator.isSameDay(
                    $0.date,
                    selectedDate
                )
            }
            .sorted {
                $0.date < $1.date
            }
    }
    
    @State private var isShowingAddSchedule = false
    
    @State private var selectedSchedule: CoupleSchedule?
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            
            // MARK: - Background
            
            SAITColors.background
                .ignoresSafeArea()
            
            // MARK: - Content
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    CalendarHeaderView(
                        onAddSchedule: {
                            isShowingAddSchedule = true
                        }
                    )
                    
                    CalendarMonthView(
                        displayedMonth: displayedMonth,
                        onPreviousMonth: {
                            changeMonth(by: -1)
                        },
                        onNextMonth: {
                            changeMonth(by: 1)
                        },
                        selectedDate: selectedDate,
                        onSelectDate: { date in
                            selectedDate = date
                        }
                    )
                    
                    CalendarScheduleListView(
                        selectedDate: selectedDate,
                        schedules: selectedDateSchedules,
                        onSelectSchedule: { schedule in
                            selectedSchedule = schedule
                        }
                    )
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .sheet(isPresented: $isShowingAddSchedule) {
            CalendarScheduleAddView(
                initialDate: selectedDate,
                onSave: { schedule in
                    addSchedule(schedule)
                }
            )
        }
        .sheet(item: $selectedSchedule) { schedule in
            CalendarScheduleDetailView(
                schedule: schedule
            )
        }
    }
    
}

// MARK: - Actions

private extension CalendarView {
    
    func changeMonth(by value: Int) {
        displayedMonth = CalendarCalculator.addingMonths(
            value,
            to: displayedMonth
        )
        
        selectedDate = displayedMonth
    }
    
    func addSchedule(_ schedule: CoupleSchedule) {
        schedules.append(schedule)
        
        selectedDate = schedule.date
        
        displayedMonth = CalendarCalculator.startOfMonth(
            for: schedule.date
        )
    }
    
}

// MARK: - Preview

#Preview {
    CalendarView()
}
