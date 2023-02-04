//
//  Post.swift
//  Networking
//
//  Created by karim  on 09/08/2022.
//

import Foundation

import Foundation

// MARK: - PostResponse
struct PostResponse: Codable {
    let data: [PostModel]?
    let total, page, limit: Int?
}

// MARK: - Datum
struct PostModel: Codable {
    let id: String?
    let image: String?
    let likes: Int?
    let tags: [String]?
    let text, publishDate, updatedDate: String?
    let owner: Owner?
}

// MARK: - Owner
struct Owner: Codable {
    let id, firstName, lastName: String?
    let title: Title?
    let picture: String?
}

enum Title: String, Codable {
    case miss = "miss"
    case mr = "mr"
    case mrs = "mrs"
    case ms = "ms"
}
