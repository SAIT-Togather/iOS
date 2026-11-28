//
//  MemoryCategoryFilterView.swift
//  SAIT
//
//  Created by 이머영 on 11/25/26.
//

import SwiftUI

struct MemoryCategoryFilterView: View {
    
    // MARK: - Properties
    
    @Binding var selectedCategory: MemoryCategory?
    
    var showsAllCategory: Bool = true
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                if showsAllCategory {
                    categoryButton(
                        title: "전체",
                        category: nil
                    )
                }
                
                ForEach(MemoryCategory.allCases) { category in
                    categoryButton(
                        title: category.title,
                        category: category
                    )
                }
            }
        }
    }
    
}

// MARK: - Components

private extension MemoryCategoryFilterView {
    
    func categoryButton(
        title: String,
        category: MemoryCategory?
    ) -> some View {

        let isSelected = selectedCategory == category

        return Button {
            selectedCategory = category
        } label: {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(
                    isSelected ? .white : SAITColors.secondaryText
                )
                .padding(.horizontal, 16)
                .frame(minHeight: 36)
                .background {
                    Capsule()
                        .fill(
                            isSelected
                                ? SAITColors.primary
                                : SAITColors.cardBackground
                        )
                }
                .overlay {
                    Capsule()
                        .strokeBorder(
                            isSelected ? Color.clear : SAITColors.border,
                            lineWidth: 1
                        )
                }
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
    
}

// MARK: - Preview

private struct MemoryCategoryFilterPreview: View {

    @State private var selectedCategory: MemoryCategory?

    var body: some View {
        MemoryCategoryFilterView(
            selectedCategory: $selectedCategory
        )
        .padding(20)
        .background(SAITColors.background)
    }
}

// MARK: - Preview

#Preview {
    MemoryCategoryFilterPreview()
}
