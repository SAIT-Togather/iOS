//
//  MemoryDetailView.swift
//  SAIT
//
//  Created by 이머영 on 11/28/26.
//

import SwiftUI

struct MemoryDetailView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var memoryStore: MemoryStore
    
    // MARK: - Properties
    
    let memory: CoupleMemory
    let onDelete: (CoupleMemory) -> Void
    
    @State private var isShowingDeleteAlert = false
    @State private var isShowingEditSheet = false
    
    // MARK: - Computed Properties
    
    private var currentMemory: CoupleMemory {
        memoryStore.memories.first {
            $0.id == memory.id
        } ?? memory
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                SAITColors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        memoryInfoCard
                        memoryPhotosCard
                        deleteButton
                    }
                    .padding(20)
                }
            }
            .navigationTitle("추억 상세")
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
                        isShowingEditSheet = true
                    }
                    .foregroundStyle(SAITColors.primary)
                }
            }
        }
        .sheet(isPresented: $isShowingEditSheet) {
            MemoryAddView(editingMemory: currentMemory)
                .environmentObject(memoryStore)
        }
        .alert(
            "추억을 삭제할까요?",
            isPresented: $isShowingDeleteAlert
        ) {
            Button("취소", role: .cancel) { }
            
            Button("삭제", role: .destructive) {
                onDelete(currentMemory)
            }
        } message: {
            Text("'\(currentMemory.title)' 추억을 삭제하면 다시 복구할 수 없어요.")
        }
    }
}

// MARK: - Memory Information

private extension MemoryDetailView {
    
    var memoryInfoCard: some View {
        SAITCard {
            VStack(alignment: .leading, spacing: 24) {
                
                HStack(spacing: 12) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 22))
                        .foregroundStyle(SAITColors.primary)
                        .frame(width: 48, height: 48)
                        .background(SAITColors.lightBlue)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(currentMemory.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(SAITColors.primary)
                        
                        Text("우리의 소중한 추억")
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
                
                if let category = currentMemory.category {
                    infoRow(
                        icon: "tag",
                        title: "카테고리",
                        value: category.title
                    )
                }
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
        currentMemory.date.formatted(
            .dateTime
                .year()
                .month()
                .day()
                .weekday(.wide)
                .locale(Locale(identifier: "ko_KR"))
        )
    }
    
}

// MARK: - Memory Photos

private extension MemoryDetailView {
    
    var memoryPhotosCard: some View {
        SAITCard {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(spacing: 8) {
                    Image(systemName: "photo.stack")
                        .foregroundStyle(SAITColors.primary)
                    
                    Text("추억 사진")
                        .foregroundStyle(SAITColors.primaryText)
                    
                    Spacer()
                    
                    Text("\(currentMemory.photos.count)장")
                        .foregroundStyle(SAITColors.secondaryText)
                }
                .font(.system(size: 15, weight: .semibold))
                
                if currentMemory.photos.isEmpty {
                    Text("등록된 사진이 없어요.")
                        .font(.system(size: 14))
                        .foregroundStyle(SAITColors.secondaryText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                } else {
                    TabView {
                        ForEach(currentMemory.photos) { photo in
                            MemoryThumbnailView(photo: photo)
                                .padding(.bottom, currentMemory.photos.count > 1 ? 28 : 0)
                        }
                    }
                    .tabViewStyle(
                        .page(
                            indexDisplayMode: currentMemory.photos.count > 1
                                ? .always
                                : .never
                        )
                    )
                    .indexViewStyle(
                        .page(backgroundDisplayMode: .always)
                    )
                    .frame(height: 300)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

// MARK: - Delete Button

private extension MemoryDetailView {
    
    var deleteButton: some View {
        Button(role: .destructive) {
            isShowingDeleteAlert = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "trash")
                Text("추억 삭제")
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

// MARK: - Preview

#Preview {
    MemoryDetailView(
        memory: CoupleMemory(
            title: "함께한 주말 데이트",
            date: Date(),
            photos: [
                MemoryPhoto(source: .asset(name: "memory_sample_1"))
            ],
            category: .date
        ),
        onDelete: { memory in
            print("삭제 요청: \(memory.title)")
        }
    )
    .environmentObject(MemoryStore())
}
