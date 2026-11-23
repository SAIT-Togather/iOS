//
//  CalendarScheduleDetailView.swift
//  SAIT
//
//  Created by 이머영 on 11/23/26.
//

import SwiftUI

struct CalendarScheduleDetailView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Properties
    
    let schedule: CoupleSchedule
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                SAITColors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        scheduleInfoCard
                        
                        deleteButton
                    }
                    .padding(20)
                }
            }
            .navigationTitle("일정 상세")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("닫기") {
                        dismiss()
                    }
                    .foregroundStyle(SAITColors.secondaryText)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("수정") {
                        // TODO: 다음 단계에서 구현
                    }
                    .foregroundStyle(SAITColors.primary)
                }
            }
        }
    }
    
}

// MARK: - Schedule Information

private extension CalendarScheduleDetailView {
    
    var scheduleInfoCard: some View {
        SAITCard {
            VStack(alignment: .leading, spacing: 24) {
                
                HStack(spacing: 12) {
                    
                    Image(systemName: "heart")
                        .font(.system(size: 22))
                        .foregroundStyle(SAITColors.primary)
                        .frame(width: 48, height: 48)
                        .background(SAITColors.lightBlue)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(schedule.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(SAITColors.primary)
                        
                        Text("우리의 소중한 일정")
                            .font(.system(size: 12))
                            .foregroundStyle(SAITColors.secondaryText)
                    }
                }
                
                Divider()
                
                infoRow(
                    icon: "calendar",
                    title: "날짜",
                    value: dateText
                )
                
                infoRow(
                    icon: "clock",
                    title: "시간",
                    value: timeText
                )
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func infoRow(
        icon: String,
        title: String,
        value: String
    ) -> some View {
        HStack(spacing: 14) {
            
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(SAITColors.primary)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(SAITColors.secondaryText)
                
                Text(value)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(SAITColors.primaryText)
            }
            
            Spacer()
        }
    }
    
    var dateText: String {
        schedule.date.formatted(
            .dateTime
                .year()
                .month()
                .day()
                .weekday(.wide)
                .locale(Locale(identifier: "ko_KR"))
        )
    }
    
    var timeText: String {
        schedule.date.formatted(
            .dateTime
                .hour()
                .minute()
                .locale(Locale(identifier: "ko_KR"))
        )
    }
    
}

// MARK: - Delete Button

private extension CalendarScheduleDetailView {
    
    var deleteButton: some View {
        Button {
            // TODO: 다음 단계에서 구현
        } label: {
            HStack(spacing: 8) {
                
                Image(systemName: "trash")
                
                Text("일정 삭제")
            }
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(SAITColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.red.opacity(0.2), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CalendarScheduleDetailView(
        schedule: CoupleSchedule(
            title: "주말 영화 데이트",
            date: Date()
        )
    )
}
