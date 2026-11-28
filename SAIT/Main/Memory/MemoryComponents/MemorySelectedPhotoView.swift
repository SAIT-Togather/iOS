//
//  MemorySelectedPhotoView.swift
//  SAIT
//
//  Created by 이머영 on 11/28/26.
//

import SwiftUI
import PhotosUI
import UIKit

struct MemorySelectedPhotoView: View {
    
    // MARK: - Properties
    
    let item: PhotosPickerItem
    let isRepresentative: Bool
    
    // MARK: - State
    
    @State private var image: UIImage?
    @State private var isLoading = true
    
    // MARK: - Body
    
    var body: some View {
        Rectangle()
            .fill(SAITColors.lightBlue)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                photoContent
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .topLeading) {
                if isRepresentative {
                    representativeLabel
                        .frame(width: 44, height: 44)
                        .allowsHitTesting(false)
                }
            }
            .task(id: item) {
                await loadImage()
            }
    }
    
}

// MARK: - Components

private extension MemorySelectedPhotoView {
    
    @ViewBuilder
    var photoContent: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else if isLoading {
            ProgressView()
                .tint(SAITColors.primary)
        } else {
            Image(systemName: "exclamationmark.triangle")
                .foregroundStyle(SAITColors.secondaryText)
                .accessibilityLabel("사진을 불러오지 못했습니다")
        }
    }
    
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

// MARK: - Actions

private extension MemorySelectedPhotoView {
    
    @MainActor
    func loadImage() async {
        image = nil
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            guard let data = try await item.loadTransferable(
                type: Data.self
            ) else {
                return
            }
            
            guard !Task.isCancelled else { return }
            
            image = UIImage(data: data)
        } catch {
            guard !Task.isCancelled else { return }
            
            image = nil
        }
    }
    
}
