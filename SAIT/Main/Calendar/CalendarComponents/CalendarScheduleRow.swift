//
//  CalendarScheduleRow.swift
//  SAIT
//
//  Created by 이머영 on 11/15/26.
//

import SwiftUI

struct CalendarScheduleRow: View {
 
    // MARK: - Properties
    
    let schedule: CoupleSchedule
    let onSelect: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                
                Image(systemName: "heart")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(SAITColors.primary)
                    .frame(width: 44, height: 44)
                    .background(SAITColors.lightBlue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(schedule.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(SAITColors.primaryText)
                    
                    Text("함께하는 소중한 시간")
                        .font(.system(size: 12))
                        .foregroundStyle(SAITColors.secondaryText)
                }
                
                Spacer(minLength: 0)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(SAITColors.secondaryText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
}

#Preview {
    CalendarScheduleRow(
        schedule: CoupleSchedule(
            title: "영화 데이트",
            date: Date()
        ), onSelect: { }
    )
    .padding(20)
}
