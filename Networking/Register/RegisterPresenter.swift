//
//  RegisterPresenter.swift
//  Networking
//
//  Created by karim  on 14/08/2022.
//

import Foundation

class RegisterPresenter {
    
    var user: ErrorClass!
    weak var view: RegisterView?
    private let AuthRepository: AuthRepositoryProtocol
    init(view: RegisterView , AuthRepository: AuthRepositoryProtocol) {
        self.view = view
        self.AuthRepository = AuthRepository
    }
    
    func CreateUser(firstName: String, lastName: String, email: String) {
        AuthRepository.createUser(firstName: firstName, lastName: lastName, email: email) { results in
            switch results {
            case .success(let user):
            self.user = user.data
                if user.error != nil {
                    let firstNameError = user.data?.firstName ?? ""
                    let lastNameError = user.data?.lastName ?? ""
                    let emailError = user.data?.email ?? ""
                    let errorMessage = firstNameError + " " + lastNameError + " " + emailError
                    self.view?.showAlert(message: errorMessage)
                }
                
                else {
                    self.view?.showAlert(message: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}



