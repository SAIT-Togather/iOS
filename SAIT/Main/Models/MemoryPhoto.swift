//
//  MemoryPhoto.swift
//  SAIT
//
//  Created by 이머영 on 11/28/26.
//

import Foundation

nonisolated struct MemoryPhoto: Identifiable, Sendable {

    // MARK: - Properties

    let id: UUID
    let source: Source

    // MARK: - Source

    enum Source: Sendable {
        case asset(name: String)
        case inMemory(data: Data)
    }

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        source: Source
    ) {
        self.id = id
        self.source = source
    }
}
