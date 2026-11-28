//
//  MemoryView.swift
//  SAIT
//
//  Created by 이머영 on 11/12/26.
//

import SwiftUI

struct MemoryView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var memoryStore: MemoryStore
    
    @State private var selectedCategory: MemoryCategory? = nil
    
    @State private var isShowingAddMemory = false
    
    @State private var selectedMemory: CoupleMemory?
    
    private var filteredMemories: [CoupleMemory] {
        guard let selectedCategory else {
            return memoryStore.memories
        }
        
        return memoryStore.memories.filter {
            $0.category == selectedCategory
        }
    }
    
    private var monthSections: [MemoryMonthSection] {
        MemoryCalculator.monthSections(
            from: filteredMemories
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            
            // MARK: - Background
            
            SAITColors.background
                .ignoresSafeArea()
            
            // MARK: - Content
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    MemoryHeaderView(
                        onAddMemory: {
                            isShowingAddMemory = true
                        }
                    )
                    
                    MemoryCategoryFilterView(
                        selectedCategory: $selectedCategory
                    )
                    
                    if memoryStore.memories.isEmpty {

                        MemoryEmptyView(
                            selectedCategory: nil
                        )

                    } else if filteredMemories.isEmpty {

                        MemoryEmptyView(
                            selectedCategory: selectedCategory
                        )

                    } else {

                        LazyVStack(spacing: 24) {
                            ForEach(monthSections) { section in
                                MemoryMonthSectionView(
                                    month: section.month,
                                    memories: section.memories,
                                    onToggleLike: { memory in
                                        memoryStore.toggleLike(
                                            for: memory
                                        )
                                    },
                                    onSelectMemory: { memory in
                                        selectedMemory = memory
                                    }
                                )
                            }
                        }

                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .sheet(isPresented: $isShowingAddMemory) {
            MemoryAddView()
        }
        .sheet(item: $selectedMemory) { memory in
            MemoryDetailView(
                memory: memory,
                onDelete: { memory in
                    memoryStore.deleteMemory(memory)
                    selectedMemory = nil
                }
            )
        }
    }
    
}

// MARK: - Preview

#Preview {
    MemoryView()
        .environmentObject(
            MemoryStore(
                memories: MemoryMockData.memories
            )
        )
}

//#Preview {
//    MemoryView()
//        .environmentObject(
//            MemoryStore(
//                memories: MemoryMockData.memories.filter {
//                    $0.category == .date
//                }
//            )
//        )
//}
