//
//  MemoryCardView.swift
//  SAIT
//
//  Created by 이머영 on 11/26/26.
//

import SwiftUI

struct MemoryCardView: View {
    
    // MARK: - Properties
    
    let memory: CoupleMemory
    let onToggleLike: () -> Void
    let onSelect: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            // MARK: - Thumbnail
            
            Button(action: onSelect) {
                MemoryThumbnailView(
                    photo: memory.representativePhoto
                )
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("\(memory.title) 추억 상세 보기")
            
            // MARK: - Information
            
            HStack(alignment: .top, spacing: 8) {
                
                Button(action: onSelect) {
                    VStack(alignment: .leading, spacing: 6) {
                        
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
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 44,
                        alignment: .topLeading
                    )
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                // MARK: - Like Button
                
                Button(action: onToggleLike) {
                    Image(
                        systemName: memory.isLiked
                            ? "heart.fill"
                            : "heart"
                    )
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(
                        memory.isLiked
                        ? SAITColors.primary
                        : SAITColors.secondaryText
                    )
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(
                    memory.isLiked ? "좋아요 취소" : "좋아요"
                )
            }
            
        }
    }
    
}

// MARK: - Preview

private struct MemoryCardPreview: View {

    @State private var memory = CoupleMemory(
        title: "함께한 첫 여행",
        date: Date(),
        photos: [
            MemoryPhoto(source: .asset(name: "memory_sample_1"))
        ],
        category: .travel,
    )

    var body: some View {
        MemoryCardView(
            memory: memory,
            onToggleLike: {
                memory.isLiked.toggle()
            },
            onSelect: {
                print("추억 선택: \(memory.title)")
            }
        )
        .frame(width: 160)
        .padding(20)
        .background(SAITColors.background)
    }
}

#Preview {
    MemoryCardPreview()
//        .environment(\.locale, Locale(identifier: "ko_KR"))
}
