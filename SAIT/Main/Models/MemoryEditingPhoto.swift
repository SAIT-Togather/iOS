//
//  MemoryEditingPhoto.swift
//  SAIT
//
//  Created by 이머영 on 11/28/26.
//

import Foundation
import PhotosUI
import SwiftUI

struct MemoryEditingPhoto: Identifiable {
    
    enum Source {
        case existing(MemoryPhoto)
        case selected(PhotosPickerItem)
    }
    
    let id: UUID
    let source: Source
    
    init(existing photo: MemoryPhoto) {
        self.id = photo.id
        self.source = .existing(photo)
    }
    
    init(selected item: PhotosPickerItem) {
        self.id = UUID()
        self.source = .selected(item)
    }
    
}
