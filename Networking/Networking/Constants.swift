//
//  Constants.swift
//  Networking
//
//  Created by karim  on 07/08/2022.
//

import Foundation

enum Constants {
    
 static let baseURL = "https://dummyapi.io/data/v1/"
    
    enum AuthEndPoints {
        static let post = "post"
        static let comment = "comment"
        static let user = "user"
        static let tag = "tag"
        static let createUser = "/create"
        static let createComment = "/create"
        static let createPost = "/create"
    }
}
