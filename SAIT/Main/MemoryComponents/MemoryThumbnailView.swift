//
//  MemoryThumbnailView.swift
//  SAIT
//
//  Created by 이머영 on 11/26/26.
//

import SwiftUI

struct MemoryThumbnailView: View {
    
    // MARK: - Properties
    
    let imageName: String
    
    // MARK: - Body
    
    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
    }
}
