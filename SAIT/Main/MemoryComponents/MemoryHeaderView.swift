//
//  MemoryHeaderView.swift
//  SAIT
//
//  Created by 이머영 on 11/25/26.
//

import SwiftUI

struct MemoryHeaderView: View {
    
    //MARK: - Properties
    
    let onAddMemory: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            // MARK: - Title
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("우리의 추억")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(SAITColors.primaryText)
                
                Text("함께한 순간들을 모아봐요")
                    .font(.system(size: 12))
                    .foregroundStyle(SAITColors.secondaryText)
            }
            
            Spacer(minLength: 8)
            
            Button(action: onAddMemory) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(SAITColors.primary)
                    .frame(width: 44, height: 44)
                    .background(SAITColors.lightBlue)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("추억 추가")
        }
    }
    
}

// MARK: - Preview

#Preview {
    MemoryHeaderView {
        print("추억 추가 버튼 선택")
    }
    .padding(20)
    .background(SAITColors.background)
}
