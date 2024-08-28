//
//  Photo.swift
//  AdvaTask
//
//  Created by Mahmoud on 28/08/2024.
//

import Foundation

// MARK: - Entities
struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
