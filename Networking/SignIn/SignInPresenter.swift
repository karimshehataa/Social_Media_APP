//
//  SignInPresenter.swift
//  Networking
//
//  Created by karim  on 17/08/2022.
//

import Foundation
import Alamofire

class SignInPresenter {
    
    var user: UserResponse?
    private let authRepository : AuthRepositoryProtocol
    init(authRepository:AuthRepositoryProtocol ) {
        self.authRepository = authRepository
    }
    
     func getAllUsersCreated(firstName:String,lastName:String,completionHandler: @escaping (UserModel?,String?) -> Void) {
        
        authRepository.signInUser(firstName: firstName, lastName: lastName) { results in
            switch results {
            case .success(let users):
                self.user = users
                var foundUser: UserModel?
                for user in users.data! {
                    if user.firstName == firstName  {
                        foundUser = user
                        print(users)
                        break
                    }
                }
//                kkkkkkkddk
//                dldkdkdkdkdkd
    
                if let user = foundUser  {
                    UserDefaults.standard.set(user.id, forKey: "userId")
                    completionHandler(user,nil)
                }
                else {
                    completionHandler(nil,"The FirstName Or The LastName Do Not Match Any User")
                }
//                print(users)
            case .failure(let error):
                print(error)
            }
        }
    }
}
