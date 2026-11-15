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
    
    // MARK: - Body
    
    var body: some View {
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

#Preview {
    CalendarScheduleRow(
        schedule: CoupleSchedule(
            title: "영화 데이트",
            date: Date()
        )
    )
    .padding(20)
}
