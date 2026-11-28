//
//  NextDateCardView.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import SwiftUI

struct NextDateCardView: View {
    let schedule: CoupleSchedule?
    let remainingDays: Int?

    var body: some View {
        SAITCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "calendar")
                        .font(.system(size: 20))
                        .foregroundStyle(SAITColors.primary)
                        .frame(width: 44, height: 44)
                        .background(SAITColors.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    VStack(alignment: .leading, spacing: 4) {
                        Text("다음 데이트")
                            .font(.system(size: 12))
                            .foregroundStyle(SAITColors.secondaryText)

                        if let schedule {
                            Text(schedule.title)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(SAITColors.primaryText)
                                .lineLimit(1)
                        } else {
                            Text("예정된 데이트가 없어요")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(SAITColors.primaryText)
                        }
                    }

                    Spacer(minLength: 8)

                    if let remainingDays {
                        Text(
                            remainingDays == 0
                                ? "D-Day"
                                : "D-\(remainingDays)"
                        )
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(SAITColors.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(SAITColors.lightBlue)
                        .clipShape(Capsule())
                    }
                }

                Rectangle()
                    .fill(SAITColors.border)
                    .frame(height: 1)

                if let schedule {
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .font(.system(size: 13))

                        Text(
                            schedule.date.formatted(
                                .dateTime
                                    .year()
                                    .month(.twoDigits)
                                    .day(.twoDigits)
                                    .weekday(.abbreviated)
                                    .locale(Locale(identifier: "ko_KR"))
                            )
                        )
                        .font(.system(size: 12))
                    }
                    .foregroundStyle(SAITColors.secondaryText)
                } else {
                    Text("캘린더에서 새로운 데이트 일정을 등록해 보세요.")
                        .font(.system(size: 12))
                        .foregroundStyle(SAITColors.secondaryText)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}
