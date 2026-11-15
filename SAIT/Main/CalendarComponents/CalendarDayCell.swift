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
    let onSelect: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if let day {
                Button(action: onSelect) {
                    Text("\(day)")
                        .font(.system(
                            size: 15,
                            weight: isToday || isSelected
                                ? .semibold
                                : .medium
                        ))
                        .foregroundStyle(dayTextColor)
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
                }
                .buttonStyle(.plain)
                .accessibilityLabel("\(day)일")
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
    
}

#Preview {
    HStack(spacing: 8) {
        CalendarDayCell(
            day: 14,
            weekdayIndex: 6,
            isToday: false,
            isSelected: false,
            onSelect: {}
        )
        
        CalendarDayCell(
            day: 15,
            weekdayIndex: 0,
            isToday: true,
            isSelected: false,
            onSelect: {}
        )
        
        CalendarDayCell(
            day: 16,
            weekdayIndex: 1,
            isToday: false,
            isSelected: true,
            onSelect: {}
        )
    }
    .padding()
}
