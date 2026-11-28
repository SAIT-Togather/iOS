//
//  MemoryMonthSectionView.swift
//  SAIT
//
//  Created by 이머영 on 11/26/26.
//

import SwiftUI

struct MemoryMonthSectionView: View {

    // MARK: - Properties
    
    let month: Date
    let memories: [CoupleMemory]
    let onToggleLike: (CoupleMemory) -> Void
    let onSelectMemory: (CoupleMemory) -> Void
    
    private let columns = [
        GridItem(.flexible(), spacing: 12, alignment: .top),
        GridItem(.flexible(), spacing: 12, alignment: .top)
    ]
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: - Month Title
            
            Text(
                month.formatted(
                    .dateTime
                        .year()
                        .month(.wide)
                )
            )
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(SAITColors.primaryText)
            
            // MARK: - Memory Grid
            
            LazyVGrid(
                columns: columns,
                alignment: .leading,
                spacing: 16
            ) {
                ForEach(memories) { memory in
                    MemoryCardView(
                        memory: memory,
                        onToggleLike: {
                            onToggleLike(memory)
                        },
                        onSelect: {
                            onSelectMemory(memory)
                        }
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

// MARK: - Preview

private struct MemoryMonthSectionPreview: View {

    @State private var memories: [CoupleMemory] = [
        CoupleMemory(
            title: "바다 여행",
            date: Date(),
            photos: [
                MemoryPhoto(source: .asset(name: "memory_sample_1"))
            ],
            category: .travel
        ),
        CoupleMemory(
            title: "카페 데이트",
            date: Date(),
            photos: [
                MemoryPhoto(source: .asset(name: "memory_sample_1"))
            ],
            category: .date
        ),
        CoupleMemory(
            title: "우리의 기념일",
            date: Date(),
            photos: [
                MemoryPhoto(source: .asset(name: "memory_sample_1"))
            ],
            category: .anniversary
        )
    ]

    var body: some View {
        ScrollView {
            MemoryMonthSectionView(
                month: Date(),
                memories: memories,
                onToggleLike: { memory in
                    guard let index = memories.firstIndex(
                        where: { $0.id == memory.id }
                    ) else {
                        return
                    }

                    memories[index].isLiked.toggle()
                },
                onSelectMemory: { memory in
                    print("선택한 추억: \(memory.title)")
                }
            )
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(SAITColors.background)
    }
}

#Preview {
    MemoryMonthSectionPreview()
        .environment(\.locale, Locale(identifier: "ko_KR"))
}
