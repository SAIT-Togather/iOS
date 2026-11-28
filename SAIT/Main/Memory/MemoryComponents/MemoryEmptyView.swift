//
//  MemoryEmptyView.swift
//  SAIT
//
//  Created by 이머영 on 11/27/26.
//

import SwiftUI

struct MemoryEmptyView: View {

    // MARK: - Properties

    let selectedCategory: MemoryCategory?

    // MARK: - Body

    var body: some View {
        VStack(spacing: 12) {

            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 32))
                .foregroundStyle(SAITColors.primary)

            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(SAITColors.primaryText)

            Text(message)
                .font(.system(size: 12))
                .foregroundStyle(SAITColors.secondaryText)

        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(SAITColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(SAITColors.border, lineWidth: 1)
        }
    }
}

// MARK: - Content

private extension MemoryEmptyView {

    var title: String {
        guard let selectedCategory else {
            return "아직 등록된 추억이 없어요"
        }

        return "아직 \(selectedCategory.title) 추억이 없어요"
    }

    var message: String {
        guard selectedCategory != nil else {
            return "함께한 소중한 순간을 기록해 보세요."
        }

        return "다른 카테고리를 선택하거나 새로운 추억을 기록해 보세요."
    }
}

// MARK: - Preview

#Preview {
    ScrollView {
        VStack(spacing: 24) {

            MemoryEmptyView(
                selectedCategory: nil
            )

            MemoryEmptyView(
                selectedCategory: .travel
            )

        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
    .background(SAITColors.background)
}
