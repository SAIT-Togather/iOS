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
    
    @EnvironmentObject private var scheduleStore: ScheduleStore
    private var selectedDateSchedules: [CoupleSchedule] {
        scheduleStore.schedules(on: selectedDate)
    }
    
    private var scheduledDates: Set<Date> {
        scheduleStore.scheduledDates
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
                        },
                        scheduledDates: scheduledDates
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
                schedule: schedule,
                onUpdate: { updatedSchedule in
                    updateSchedule(updatedSchedule)
                },
                onDelete: { schedule in
                    deleteSchedule(schedule)
                }
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
        scheduleStore.addSchedule(schedule)
        
        selectedDate = schedule.date
        
        displayedMonth = CalendarCalculator.startOfMonth(
            for: schedule.date
        )
    }
    
    func updateSchedule(_ updatedSchedule: CoupleSchedule) {
        scheduleStore.updateSchedule(updatedSchedule)
        
        selectedDate = updatedSchedule.date
        
        displayedMonth = CalendarCalculator.startOfMonth(
            for: updatedSchedule.date
        )
        
        selectedSchedule = nil
    }
    
    func deleteSchedule(_ schedule: CoupleSchedule) {
        scheduleStore.deleteSchedule(schedule)
        
        selectedSchedule = nil
    }
    
}

// MARK: - Preview

#Preview {
    CalendarView()
        .environmentObject(
            ScheduleStore(
                schedules: CalendarMockData.schedules
            )
        )
}
