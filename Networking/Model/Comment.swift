//
//  Comment.swift
//  Networking
//
//  Created by karim  on 10/08/2022.
//

import Foundation

// MARK: - CommentResponse
struct CommentResponse: Codable {
    let data: [CommentModel]?
    let total, page, limit: Int?
}

// MARK: - CommentModel
struct CommentModel: Codable {
    let id, message: String?
    let owner: Owner?
    let post, publishDate: String?
}



