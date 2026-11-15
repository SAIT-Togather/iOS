//
//  CalendarHeaderView.swift
//  SAIT
//
//  Created by 이머영 on 11/15/26.
//

import SwiftUI

struct CalendarHeaderView: View {
    
    // MARK: - Properties
    
    let onAddSchedule: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            // MARK: - Title
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("캘린더")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(SAITColors.primaryText)
                
                Text("우리의 소중한 일정을 함께 기록해요.")
                    .font(.system(size: 12))
                    .foregroundStyle(SAITColors.secondaryText)
            }
            
            Spacer(minLength: 8)
            
            // MARK: - Add Schedule Button
            
            Button(action: onAddSchedule) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(SAITColors.primary)
                    .frame(width: 44, height: 44)
                    .background(SAITColors.lightBlue)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("일정 추가")
        }
    }
    
}

// MARK: - Preview

#Preview {
    CalendarHeaderView {
        print("일정 추가 버튼 선택")
    }
    .padding(20)
    .background(SAITColors.background)
}
