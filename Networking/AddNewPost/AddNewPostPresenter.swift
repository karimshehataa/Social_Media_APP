//
//  AddNewPostPresenter.swift
//  Networking
//
//  Created by karim  on 24/08/2022.
//

import Foundation

class AddNewPostPresenter {
    
    var ddd: PostPresenter!
    var posts: [PostModel]!
    var ownerId: CreatePostResponse!
    weak var view: PostView?
    private let AuthRepository: AuthRepositoryProtocol
    init(view: PostView,AuthRepository: AuthRepositoryProtocol) {
        self.view = view
        self.AuthRepository = AuthRepository
    }
    
    func CreatePost(text: String) {
        let userLogedInId = UserDefaults.standard.string(forKey: "userId")
        AuthRepository.createPost(owner: userLogedInId ?? "", text: text) { results in
            print("aaaæaaaaa")
        }
    }


}
