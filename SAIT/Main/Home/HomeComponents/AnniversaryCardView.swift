//
//  AnniversaryCardView.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import SwiftUI

struct AnniversaryCardView: View {
    let days: Int?
    let date: Date?
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
                        Text("다가오는 기념일")
                            .font(.system(size: 12))
                            .foregroundStyle(SAITColors.secondaryText)

                        if let days {
                            Text("\(days)일 기념일")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(SAITColors.primaryText)
                        } else {
                            Text("기념일 정보가 없어요.")
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

                if let date {
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .font(.system(size: 13))

                        Text(
                            date.formatted(
                                .dateTime
                                    .year()
                                    .month(.twoDigits)
                                    .day(.twoDigits)
                            )
                        )
                        .font(.system(size: 12))
                    }
                    .foregroundStyle(SAITColors.secondaryText)
                } else {
                    Text("연애 시작일을 등록하면 기념일을 확인할 수 있어요.")
                        .font(.system(size: 12))
                        .foregroundStyle(SAITColors.secondaryText)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}
