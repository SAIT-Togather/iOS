//
//  CoupleCardView.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import SwiftUI

struct CoupleCardView: View {
    let daysTogether: Int?
    let relationshipStartDate: Date?

    var body: some View {
        SAITCard {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    profileImageView

                    Image(systemName: "heart")
                        .font(.system(size: 24))
                        .foregroundStyle(SAITColors.primary)

                    profileImageView
                }

                VStack(spacing: 8) {
                    Text("우리가 함께한 지")
                        .font(.system(size: 14))
                        .foregroundStyle(SAITColors.secondaryText)

                    if let daysTogether,
                       let relationshipStartDate {
                        Text("D+\(daysTogether)")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(SAITColors.primary)

                        Text(
                            "\(relationshipStartDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))부터 함께하고 있어요"
                        )
                        .font(.system(size: 12))
                        .foregroundStyle(SAITColors.secondaryText)
                    } else {
                        Text("우리의 시작일을 등록해 주세요")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(SAITColors.primaryText)

                        Text("연애 시작일을 등록하면 D+Day를 확인할 수 있어요.")
                            .font(.system(size: 12))
                            .foregroundStyle(SAITColors.secondaryText)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 28)
            .padding(.horizontal, 20)
        }
    }

    private var profileImageView: some View {
        Image(systemName: "person")
            .font(.system(size: 28))
            .foregroundStyle(SAITColors.primary)
            .frame(width: 68, height: 68)
            .background(SAITColors.lightBlue)
            .clipShape(Circle())
    }
    
}
