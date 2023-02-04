//
//  PostDetailsPresenter.swift
//  Networking
//
//  Created by karim  on 10/08/2022.
//

import Foundation

class PostDetailsPresenter {
    
    var authRepository: AuthRepositoryProtocol!
//    var post: PostModel!
    var postData : PostModel!
    var comment: [CommentModel]!
    weak var view: postDetailsView?
    init(view: postDetailsView , postData: PostModel,AuthRepository:AuthRepositoryProtocol) {
        self.view = view
        self.postData = postData
        self.authRepository = AuthRepository
    }
    
    func CreateComment(message: String) {
        let userLogedInId = UserDefaults.standard.string(forKey: "userId")
        authRepository.createComment(postId: (postData.id ?? ""), message: message, owner:userLogedInId ?? "") { results in
            self.getPostsComment()
            self.view?.HideTextField()
        }
    }
    
    func getPostsComment() {
        view?.showIndicator()
        authRepository.commentsPost(id: postData.id ?? "") { results in
            switch results {
            case .success(let comment):
                self.view?.hideIndicator()
                self.comment = comment.data
//                print(self.postData.id)
                self.view?.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configure(cell: configureCommentCell, at index: Int) {
        let comment = comment![index]
        cell.displayUserImage(image: (comment.owner?.picture ?? ""))
        cell.displayUserName(text: (comment.owner?.firstName)! + " " + (comment.owner?.lastName)!)
        cell.displayCommentText(text: (comment.message)!)
    }
    
    func getPostsCommentCount() -> Int {
        return comment?.count ?? 0
        
    }
}
