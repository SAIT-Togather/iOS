//
//  MemoryAddView.swift
//  SAIT
//
//  Created by 이머영 on 11/28/26.
//

import SwiftUI
import PhotosUI

struct MemoryAddView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var memoryStore: MemoryStore
    
    // MARK: - State
    
    @State private var title = ""
    @State private var memoryDate = Date()
    @State private var selectedCategory: MemoryCategory? = nil
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    
    @State private var isSaving = false
    @State private var isShowingSaveError = false
    @State private var saveTask: Task<Void, Never>?
    
    // MARK: - Focus
    
    @FocusState private var isTitleFocused: Bool
    
    // MARK: - Validation
    
    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var isFormValid: Bool {
        !trimmedTitle.isEmpty
            && selectedCategory != nil
            && !selectedPhotoItems.isEmpty
    }
    
    // MARK: Save Availability
    
    private var canSave: Bool {
        isFormValid && !isSaving
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
             
                // MARK: - Background
                
                SAITColors.background
                    .ignoresSafeArea()
                
                // MARK: - Content
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        titleSection
                        dateSection
                        categorySection
                        photoSection
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                }
                .disabled(isSaving)
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationTitle("추억 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        saveTask?.cancel()
                        dismiss()
                    }
                    .foregroundStyle(SAITColors.secondaryText)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(isSaving ? "저장 중…" : "저장") {
                        saveMemory()
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(
                        canSave
                            ? SAITColors.primary
                            : SAITColors.secondaryText
                    )
                    .disabled(!canSave)
                }
            }
        }
        .interactiveDismissDisabled(isSaving)
        .alert(
            "추억을 저장하지 못했어요",
            isPresented: $isShowingSaveError
        ) {
            Button("확인", role: .cancel) {}
        } message: {
            Text("사진을 불러오는 중 문제가 발생했어요. 다시 시도해 주세요.")
        }
        .onDisappear {
            saveTask?.cancel()
        }
    }
    
}

// MARK: - Form Sections

private extension MemoryAddView {
    
    var titleSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle("추억 제목")
            
            TextField(
                "어떤 추억을 남기고 싶나요?",
                text: $title
            )
            .font(.system(size: 15))
            .foregroundStyle(SAITColors.primaryText)
            .padding(16)
            .background(SAITColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(SAITColors.border, lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .focused($isTitleFocused)
            .submitLabel(.done)
            .onSubmit {
                isTitleFocused = false
            }
        }
    }
    
    var dateSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle("날짜")
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(SAITColors.primary)
                
                DatePicker(
                    "날짜 선택",
                    selection: $memoryDate,
                    displayedComponents: .date
                )
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
            .background(SAITColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(SAITColors.border, lineWidth: 1)
            }
        }
    }
    
    var categorySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle("카테고리")
            
            MemoryCategoryFilterView(
                selectedCategory: $selectedCategory,
                showsAllCategory: false
            )
        }
    }
    
    var photoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle("사진")
            
            PhotosPicker(
                selection: $selectedPhotoItems,
                selectionBehavior: .ordered,
                matching: .images
            ) {
                HStack(spacing: 10) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .foregroundStyle(SAITColors.primary)
                    
                    Text(
                        selectedPhotoItems.isEmpty
                            ? "사진 선택"
                            : "사진 \(selectedPhotoItems.count)장 선택됨"
                    )
                    .font(.system(size: 15))
                    .foregroundStyle(SAITColors.primaryText)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(SAITColors.secondaryText)
                }
                .padding(16)
                .background(SAITColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(SAITColors.border, lineWidth: 1)
                }
            }
            .buttonStyle(.plain)
            if !selectedPhotoItems.isEmpty {
                
                Text("첫 번째 사진이 홈과 추억 목록에 표시돼요. 사진을 길게 눌러 대표 사진을 변경할 수 있어요.")
                    .font(.system(size: 12))
                    .foregroundStyle(SAITColors.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
                
                selectedPhotosGrid
            }
        }
    }
    
    var selectedPhotosGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8)
            ],
            spacing: 8
        ) {
            ForEach(
                Array(selectedPhotoItems.enumerated()),
                id: \.element
            ) { index, item in
                MemorySelectedPhotoView(
                    item: item,
                    isRepresentative: index == 0
                )
                .contextMenu {
                    if index != 0 {
                        Button {
                            setRepresentativePhoto(item)
                        } label: {
                            Label("대표 사진으로 지정", systemImage: "star")
                        }
                    }
                }
                .overlay(alignment: .topTrailing) {
                    removePhotoButton(for: item)
                }
            }
        }
    }
    
    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(SAITColors.primaryText)
    }
    
}

// MARK: - Photo Components

private extension MemoryAddView {
    
    func removePhotoButton(
        for item: PhotosPickerItem
    ) -> some View {
        Button {
            removePhoto(item)
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 24, height: 24)
                .background(.black.opacity(0.6))
                .clipShape(Circle())
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("선택한 사진 삭제")
    }
    
}

// MARK: - Actions

private extension MemoryAddView {
    
    func removePhoto(_ item: PhotosPickerItem) {
        selectedPhotoItems.removeAll() { $0 == item }
    }
    
    func setRepresentativePhoto(_ item: PhotosPickerItem) {
        guard let index = selectedPhotoItems.firstIndex(of: item),
              index != 0 else {
            return
        }
        
        let selectedItem = selectedPhotoItems.remove(at: index)
        selectedPhotoItems.insert(selectedItem, at: 0)
    }
    
    @MainActor
    func saveMemory() {
        guard canSave else {
            return
        }

        // 저장 시작 시점의 입력값과 사진 순서를 고정
        let savedTitle = trimmedTitle
        let savedDate = memoryDate
        let savedCategory = selectedCategory
        let savedPhotoItems = selectedPhotoItems

        isSaving = true
        isTitleFocused = false

        saveTask = Task { @MainActor in
            defer {
                isSaving = false
                saveTask = nil
            }

            do {
                let loader = MemoryPhotoLoader()

                let photos = try await loader.load(
                    items: savedPhotoItems
                )

                try Task.checkCancellation()

                let memory = CoupleMemory(
                    title: savedTitle,
                    date: savedDate,
                    photos: photos,
                    category: savedCategory
                )

                memoryStore.addMemory(memory)

                dismiss()

            } catch is CancellationError {
                // 사용자가 취소한 경우에는 오류 Alert를 표시하지 않음

            } catch {
                guard !Task.isCancelled else {
                    return
                }

                isShowingSaveError = true
            }
        }
    }
    
}

// MARK: - Preview

#Preview {
    MemoryAddView()
        .environmentObject(MemoryStore())
}
