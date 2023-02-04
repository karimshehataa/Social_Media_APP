//
//  UserError.swift
//  Networking
//
//  Created by karim  on 31/08/2022.
//

import Foundation


// MARK: - CreateUser
struct CreateUser: Codable {
    let error: String?
    let data: ErrorClass?
}

// MARK: - DataClass
struct ErrorClass: Codable {
    let firstName: String?
    let lastName: String?
    let email: String?
}
