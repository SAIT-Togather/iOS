//
//  CalendarDayCell.swift
//  SAIT
//
//  Created by 이머영 on 11/15/26.
//

import SwiftUI

struct CalendarDayCell: View {
    
    // MARK: - Properties
    
    let day: Int?
    let weekdayIndex: Int
    
    let isToday: Bool
    let isSelected: Bool
    let hasSchedule: Bool
    let onSelect: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if let day {
                Button(action: onSelect) {
                    VStack(spacing: 4) {
                        
                        Text("\(day)")
                            .font(
                                .system(
                                    size: 15,
                                    weight: isToday || isSelected
                                    ? .semibold
                                    : .medium
                                )
                            )
                            .foregroundStyle(dayTextColor)
                        
                        scheduleIndicator
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(
                        isSelected
                            ? SAITColors.primary
                            : Color.clear
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                isToday && !isSelected
                                ? SAITColors.primary
                                : Color.clear,
                                lineWidth: 1.5
                            )
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("\(day)일")
                .accessibilityValue(
                    hasSchedule
                        ? "등록된 일정 있음"
                        : "등록된 일정 없음"
                )
                .accessibilityAddTraits(
                    isSelected ? .isSelected : []
                )
            } else {
                Color.clear
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .accessibilityHidden(true)
            }
        }
    }
    
}

// MARK: - Computed Properties

private extension CalendarDayCell {
    
    var dayTextColor: Color {
        if isSelected {
            return .white
        }
        
        if isToday {
            return SAITColors.primary
        }
        
        switch weekdayIndex {
        case 0:
            return Color(red: 0.94, green: 0.38, blue: 0.38)
            
        case 1:
            return SAITColors.primary
            
        default:
            return SAITColors.primaryText
        }
    }
    
    var scheduleIndicator: some View {
        Circle()
            .fill(
                hasSchedule
                    ? (isSelected ? Color.white : SAITColors.primary)
                    : Color.clear
            )
            .frame(width: 5, height: 5)
            .accessibilityHidden(true)
    }
    
}

#Preview {
    HStack(spacing: 12) {
        
        CalendarDayCell(
            day: 23,
            weekdayIndex: 1,
            isToday: false,
            isSelected: false,
            hasSchedule: false,
            onSelect: { }
        )
        
        CalendarDayCell(
            day: 24,
            weekdayIndex: 2,
            isToday: true,
            isSelected: false,
            hasSchedule: true,
            onSelect: { }
        )
        
        CalendarDayCell(
            day: 25,
            weekdayIndex: 3,
            isToday: false,
            isSelected: true,
            hasSchedule: true,
            onSelect: { }
        )
    }
    .padding(20)
    .background(SAITColors.background)
}
