//
//  CalendarMonthView.swift
//  SAIT
//
//  Created by 이머영 on 11/15/26.
//

import SwiftUI

struct CalendarMonthView: View {
    
    // MARK: - Properties
    
    let displayedMonth: Date
    let onPreviousMonth: () -> Void
    let onNextMonth: () -> Void
    
    private var monthDays: [Int?] {
        CalendarCalculator.daysInMonth(for: displayedMonth)
    }
    
    let selectedDate: Date
    let onSelectDate: (Date) -> Void
    
    // MARK: - Body
    
    var body: some View {
        SAITCard {
            VStack(spacing: 20) {
                
                monthNavigationView
                
                weekdayHeaderView
                
                monthGridView
            }
            .padding(16)
            .frame(maxWidth: .infinity)
        }
    }
    
}

// MARK: - Month Navigation

private extension CalendarMonthView {
    
    var monthNavigationView: some View {
        HStack {
            
            monthButton(
                systemName: "chevron.left",
                accessibilityLabel: "이전 달",
                action: onPreviousMonth
            )
            
            Spacer()
            
            Text(CalendarCalculator.monthTitle(for: displayedMonth))
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(SAITColors.primaryText)
            
            Spacer()
            
            monthButton(
                systemName: "chevron.right",
                accessibilityLabel: "다음 달",
                action: onNextMonth
            )
        }
    }
    
    func monthButton(
        systemName: String,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(SAITColors.primaryText)
                .frame(width: 36, height: 36)
                .background(SAITColors.background)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(accessibilityLabel)
    }
    
}

// MARK: Calendar Grid

private extension CalendarMonthView {
    
    var weekdayHeaderView: some View {
        HStack(spacing: 0) {
            ForEach(
                Array(CalendarCalculator.weekdaySymbols.enumerated()),
                id: \.offset
            ) { index, symbol in
                
                Text(symbol)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(weekdayColor(for: index))
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    var monthGridView: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(), spacing: 0),
                count: 7
            ),
            spacing: 8
        ) {
            ForEach(monthDays.indices, id: \.self) { index in
                
                let day = monthDays[index]
                
                let cellDate = day.flatMap {
                    CalendarCalculator.date(
                        for: $0,
                        in: displayedMonth
                    )
                }
                
                CalendarDayCell(
                    day: day,
                    weekdayIndex: index % 7,
                    isToday: cellDate.map {
                        CalendarCalculator.isToday($0)
                    } ?? false,
                    isSelected: cellDate.map {
                        CalendarCalculator.isSameDay(
                            $0,
                            selectedDate
                        )
                    } ?? false,
                    onSelect: {
                        guard let cellDate else { return }
                        onSelectDate(cellDate)
                    }
                )
            }
        }
    }
    
    func weekdayColor(for index: Int) -> Color {
        switch index {
        case 0:
            return Color(red: 0.94, green: 0.38, blue: 0.38)
            
        case 6:
            return SAITColors.primary
            
        default:
            return SAITColors.secondaryText
        }
    }
    
}

// MARK: - Preview Test

private struct CalendarMonthPreview: View {

    @State private var displayedMonth =
        CalendarCalculator.startOfMonth(for: Date())

    @State private var selectedDate = Date()

    var body: some View {
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
        .padding(20)
        .background(SAITColors.background)
    }

    private func changeMonth(by value: Int) {
        displayedMonth = CalendarCalculator.addingMonths(
            value,
            to: displayedMonth
        )

        selectedDate = displayedMonth
    }
    
}

#Preview {
    CalendarMonthPreview()
}
