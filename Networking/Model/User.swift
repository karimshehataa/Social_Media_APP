//
//  UserResponse.swift
//  Networking
//
//  Created by karim  on 14/08/2022.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let id, firstName, lastName, email: String?
    let registerDate, updatedDate: String?
    let data: [UserModel]?
}


// MARK: - UserModel
struct UserModel: Codable {
    let id, firstName, lastName,email: String?
}
