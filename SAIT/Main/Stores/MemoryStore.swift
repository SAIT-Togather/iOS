//
//  MemoryStore.swift
//  SAIT
//
//  Created by 이머영 on 11/26/26.
//

import Foundation
import Combine

@MainActor
final class MemoryStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var memories: [CoupleMemory]
    
    // MARK: - Initalizer
    
    init(memories: [CoupleMemory] = []) {
        self.memories = memories
    }
    
}

// MARK: - Actions

extension MemoryStore {
    
    func addMemory(_ memory: CoupleMemory) {
        memories.append(memory)
    }
    
    func updateMemory(_ updatedMemory: CoupleMemory) {
        guard let index = memories.firstIndex(
            where: { $0.id == updatedMemory.id }
        ) else {
            return
        }
        
        memories[index] = updatedMemory
    }
    
    func deleteMemory(_ memory: CoupleMemory) {
        memories.removeAll() {
            $0.id == memory.id
        }
    }
    
    func toggleLike(for memory: CoupleMemory) {
        guard let index = memories.firstIndex(
            where: { $0.id == memory.id }
        ) else {
            return
        }
        
        memories[index].isLiked.toggle()
    }
    
}
