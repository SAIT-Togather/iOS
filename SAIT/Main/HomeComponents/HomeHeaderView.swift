//
//  HomeHeaderView.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import SwiftUI

struct HomeHeaderView: View {
    let onNotification: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image("saitLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 2) {
                Text("SAIT")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(SAITColors.primaryText)

                Text("우리만의, 더 가까운 하루")
                    .font(.system(size: 11))
                    .foregroundStyle(SAITColors.secondaryText)
            }

            Spacer()

            Button(action: onNotification) {
                Image(systemName: "bell")
                    .font(.system(size: 20))
                    .foregroundStyle(SAITColors.primaryText)
                    .frame(width: 44, height: 44)
                    .background(SAITColors.cardBackground)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(SAITColors.border, lineWidth: 1)
                    }
            }
            .buttonStyle(.plain)
            .accessibilityLabel("알림")
        }
    }
    
}
