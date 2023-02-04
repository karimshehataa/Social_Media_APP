//
//  CreatePost.swift
//  Networking
//
//  Created by karim  on 24/08/2022.
//

import Foundation


// MARK: - CreateCommentResponse
struct CreatePostResponse: Codable {
    let id, image: String?
    let likes: Int?
    let link, text, publishDate, updatedDate: String?
}

