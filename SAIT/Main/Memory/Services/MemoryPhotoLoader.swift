//
//  MemoryPhotoLoader.swift
//  SAIT
//
//  Created by 이머영 on 11/28/26.
//

import SwiftUI
import Foundation
import PhotosUI
import CoreTransferable
import ImageIO
import UniformTypeIdentifiers

actor MemoryPhotoLoader {

    // MARK: - Load

    func load(
        items: [PhotosPickerItem]
    ) async throws -> [MemoryPhoto] {
        var photos: [MemoryPhoto] = []
        photos.reserveCapacity(items.count)

        for item in items {
            try Task.checkCancellation()

            guard let data = try await item.loadTransferable(
                type: Data.self
            ) else {
                throw LoaderError.unavailablePhoto
            }

            try Task.checkCancellation()

            let thumbnailData = try makeThumbnailData(from: data)

            photos.append(
                MemoryPhoto(
                    source: .inMemory(data: thumbnailData)
                )
            )
        }

        try Task.checkCancellation()

        return photos
    }
    
}

// MARK: - Image Processing

private extension MemoryPhotoLoader {

    func makeThumbnailData(from data: Data) throws -> Data {
        let sourceOptions: [CFString: Any] = [
            kCGImageSourceShouldCache: false
        ]

        guard let source = CGImageSourceCreateWithData(
            data as CFData,
            sourceOptions as CFDictionary
        ) else {
            throw LoaderError.invalidImage
        }

        let thumbnailOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: 1024,
            kCGImageSourceShouldCacheImmediately: true
        ]

        guard let image = CGImageSourceCreateThumbnailAtIndex(
            source,
            0,
            thumbnailOptions as CFDictionary
        ) else {
            throw LoaderError.thumbnailCreationFailed
        }

        let output = NSMutableData()

        guard let destination = CGImageDestinationCreateWithData(
            output,
            UTType.png.identifier as CFString,
            1,
            nil
        ) else {
            throw LoaderError.encodingFailed
        }

        CGImageDestinationAddImage(destination, image, nil)

        guard CGImageDestinationFinalize(destination) else {
            throw LoaderError.encodingFailed
        }

        return output as Data
    }
    
}

// MARK: - Error

extension MemoryPhotoLoader {

    enum LoaderError: Error {
        case unavailablePhoto
        case invalidImage
        case thumbnailCreationFailed
        case encodingFailed
    }
    
}
