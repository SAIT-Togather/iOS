//
//  RecentMemoriesView.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import SwiftUI

struct RecentMemoriesView: View {
    let memories: [CoupleMemory]
    let onMore: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("최근 추억")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(SAITColors.primaryText)

                Spacer()

                Button(action: onMore) {
                    HStack(spacing: 4) {
                        Text("더보기")

                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(SAITColors.primary)
                }
                .buttonStyle(.plain)
            }

            if memories.isEmpty {
                emptyMemoriesView
            } else {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(memories) { memory in
                        memoryItemView(memory)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .top
                            )
                    }
                }
            }
        }
    }

    private func memoryItemView(
        _ memory: CoupleMemory
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            
            MemoryThumbnailView(
                photo: memory.representativePhoto
            )

            Text(memory.title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(SAITColors.primaryText)
                .lineLimit(1)

            Text(
                memory.date.formatted(
                    .dateTime
                        .year()
                        .month(.twoDigits)
                        .day(.twoDigits)
                )
            )
            .font(.system(size: 10))
            .foregroundStyle(SAITColors.secondaryText)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
        }
    }

    private var emptyMemoriesView: some View {
        VStack(spacing: 12) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 32))
                .foregroundStyle(SAITColors.primary)

            Text("아직 등록된 추억이 없어요")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(SAITColors.primaryText)

            Text("함께한 소중한 순간을 기록해 보세요.")
                .font(.system(size: 12))
                .foregroundStyle(SAITColors.secondaryText)
        }
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
