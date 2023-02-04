//
//  AuthRepository.swift
//  Networking
//
//  Created by karim  on 09/08/2022.
//

import Foundation
import Alamofire

protocol AuthRepositoryProtocol:AnyObject {
    
    func getAllPosts(page:Int,limit:Int,completionHandler: @escaping (AFResult<PostResponse>) -> Void)
    func commentsPost(id: String,completionHandler: @escaping (AFResult<CommentResponse>) -> Void)
    func createUser(firstName:String,lastName:String,email:String, completionHandler: @escaping (AFResult<CreateUser>) -> Void)
    func signInUser(firstName:String,lastName:String,completionHandler: @escaping (AFResult<UserResponse>) -> Void)
    func createComment(postId:String,message:String,owner:String,completionHandler: @escaping (AFResult<CreateCommentResponse>) -> Void)
    func createPost(owner: String,text: String, completionHandler: @escaping(AFResult<PostResponse>) -> Void)

}

class AuthRepository: AuthRepositoryProtocol {
    
    private let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getAllPosts(page:Int,limit:Int,completionHandler: @escaping (AFResult<PostResponse>) -> Void) {
        let params = [
            "page": "\(page)",
            "limit": "\(limit)"
        ]
        network.request(ـ:AuthRouter.getPosts(parameter: params), decodeTo: PostResponse.self, completionHandler: completionHandler)
    }
    
    func commentsPost(id: String,completionHandler: @escaping (AFResult<CommentResponse>) -> Void) {
        let parameter = ["id":id]
        network.request(ـ: AuthRouter.getCommentsPost(parameter: parameter), decodeTo: CommentResponse.self, completionHandler: completionHandler)
    }
    
    func createUser(firstName:String,lastName:String,email:String,completionHandler: @escaping (AFResult<CreateUser>) -> Void) {
        let params = [
            "firstName":firstName,
            "lastName":lastName,
            "email":email
        ]
        network.request(ـ: AuthRouter.createUser(parameter: params), decodeTo: CreateUser.self, completionHandler: completionHandler)
    }
    
    func signInUser(firstName:String,lastName:String,completionHandler: @escaping (AFResult<UserResponse>) -> Void) {
        let params = [
            "created":"1"
        ]
        network.request(ـ: AuthRouter.signInUser(parameter: params), decodeTo: UserResponse.self, completionHandler: completionHandler)
    }
    
    func createComment(postId: String, message: String, owner: String, completionHandler: @escaping (AFResult<CreateCommentResponse>) -> Void) {
        let params = [
            "post":postId,
            "message": message,
            "owner":owner
        ]
        network.request(ـ: AuthRouter.createComment(parameter: params), decodeTo: CreateCommentResponse.self, completionHandler: completionHandler)
    }
    
    func createPost(owner: String, text: String, completionHandler: @escaping (AFResult<PostResponse>) -> Void) {
        let params = [
            "owner":owner,
            "text":text
        ]
        network.request(ـ: AuthRouter.createPost(parameters: params), decodeTo: PostResponse.self, completionHandler: completionHandler)
    }

}
