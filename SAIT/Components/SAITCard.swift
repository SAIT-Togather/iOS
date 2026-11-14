//
//  SAITCard.swift
//  SAIT
//
//  Created by 이머영 on 11/14/26.
//

import SwiftUI

struct SAITCard<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .background(SAITColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(SAITColors.border, lineWidth: 1)
            }
    }
    
}
