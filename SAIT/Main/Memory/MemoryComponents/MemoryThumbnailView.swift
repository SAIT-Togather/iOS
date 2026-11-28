//
//  MemoryThumbnailView.swift
//  SAIT
//
//  Created by 이머영 on 11/26/26.
//

import SwiftUI
import UIKit

struct MemoryThumbnailView: View {
    
    // MARK: - Properties
    
    let photo: MemoryPhoto?
    
    // MARK: - Body
    
    var body: some View {
        SAITColors.lightBlue
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                thumbnailContent
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
    }
}

// MARK: Components

private extension MemoryThumbnailView {
    
    @ViewBuilder
    var thumbnailContent: some View {
        if let photo {
            switch photo.source {
            case .asset(let name):
                Image(name)
                    .resizable()
                    .scaledToFill()

            case .inMemory(let data):
                if let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    placeholderView
                }
            }
        } else {
            placeholderView
        }
    }
    
    var placeholderView: some View {
        Image(systemName: "photo")
            .font(.system(size: 24))
            .foregroundStyle(SAITColors.secondaryText)
            .accessibilityLabel("사진 없음")
    }
    
}
