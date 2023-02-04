//
//  PostPresenter.swift
//  Networking
//
//  Created by karim  on 09/08/2022.
//

import Foundation

class PostPresenter {
    var likes:Int?
    var page = 0
    var total = 0
    var posts : [PostModel]!
    weak var view: PostView?
    private let AuthRepository: AuthRepositoryProtocol
    init(view: PostView,AuthRepository: AuthRepositoryProtocol,posts:[PostModel]) {
        self.view = view
        self.AuthRepository = AuthRepository
        self.posts = posts
    }
    
    func getPosts() {
        self.view?.showIndicator()
        AuthRepository.getAllPosts(page: page, limit:20) { posts in
            self.view?.hideIndicator()
            switch posts {
            case .success(let posts):
                self.total = posts.total ?? 0
                self.posts.append(contentsOf: posts.data!)
                self.view?.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configure(cell: ConfigureCell, at index: Int) {
        for _ in posts {
            let post = posts![index]
            cell.displayUserNameText(text: (post.owner?.firstName)! + " " + (post.owner?.lastName)!)
            cell.displayUserImage(image: post.owner?.picture ?? "")
            cell.displayPostText(text: post.text!)
            cell.displayPostImage(image: post.image!)
            cell.displayLike(text: (post.likes!))
        }
    }
    
    func getPostsCounts() -> Int {
        return posts?.count ?? 0
        
    }
    
    func didSelectRow( index: Int) -> PostModel {
        let post = posts[index]
        return post
    }
}
