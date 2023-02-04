//
//  CreateComment.swift
//  Networking
//
//  Created by karim  on 18/08/2022.
//

import Foundation

// MARK: - CreateCommentResponse
struct CreateCommentResponse: Codable {
    let id, message: String?
    let post, publishDate: String?
}



