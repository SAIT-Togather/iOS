//
//  MemoryEditingPhotoView.swift
//  SAIT
//
//  Created by 이머영 on 11/28/26.
//

import SwiftUI

struct MemoryEditingPhotoView: View {
    
    // MARK: - Properties
    
    let photo: MemoryEditingPhoto
    let isRepresentative: Bool
    
    // MARK: - Body
    
    var body: some View {
        switch photo.source {
        case .existing(let memoryPhoto):
            MemoryThumbnailView(photo: memoryPhoto)
                .overlay(alignment: .bottomLeading) {
                    if isRepresentative {
                        representativeLabel
                            .padding(6)
                    }
                }
            
        case .selected(let item):
            MemorySelectedPhotoView(
                item: item,
                isRepresentative: isRepresentative
            )
        }
    }
    
}

// MARK: - Representative Label

private extension MemoryEditingPhotoView {
    
    var representativeLabel: some View {
        Text("대표")
            .font(.system(size: 10, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
            .background(SAITColors.primary)
            .clipShape(Capsule())
    }
    
}

// MARK: - Preview

#Preview {
    HStack(alignment: .top, spacing: 8) {
        MemoryEditingPhotoView(
            photo: MemoryEditingPhoto(
                existing: MemoryPhoto(
                    source: .asset(name: "memory_sample_1")
                )
            ),
            isRepresentative: true
        )

        MemoryEditingPhotoView(
            photo: MemoryEditingPhoto(
                existing: MemoryPhoto(
                    source: .asset(name: "memory_sample_1")
                )
            ),
            isRepresentative: false
        )
    }
    .padding(20)
    .background(SAITColors.background)
}
