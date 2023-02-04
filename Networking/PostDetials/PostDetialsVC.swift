//
//  PostDetials.swift
//  Networking
//
//  Created by karim  on 10/08/2022.
//

import UIKit
import NVActivityIndicatorView

protocol postDetailsView:AnyObject {
    func showIndicator()
    func hideIndicator()
    func reloadTableView()
    func HideTextField()
}
class PostDetialsVC: UIViewController,postDetailsView{
    func HideTextField() {
        commentTF.text = ""
    }
    
    
    func showIndicator() {
        loaderView.startAnimating()
    }
    
    func hideIndicator() {
        loaderView.stopAnimating()
    }
    
    
    func reloadTableView() {
        commentTableView.reloadData()

    }
    var preseneter: PostDetailsPresenter!
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        configure()
        preseneter.getPostsComment()
    }
    
    func configure() {
        userNameLabel.text = (preseneter.postData.owner?.firstName)! + " " + (preseneter.postData.owner?.lastName)!
        
        if let userImage = preseneter.postData.owner?.picture {
            userImageView.setImageFromStringrlL(stringUrl: userImage)
            userImageView.makeImagrCircle()
        }
        
        postTextLabel.text = preseneter.postData.text
        
        if let postImage = preseneter.postData.image {
            postImageView.setImageFromStringrlL(stringUrl: postImage)
        }
        
        likesLabel.text = String(preseneter.postData.likes ?? 0 )

    }
    
    
    @IBAction func CommentSendBtn(_ sender: Any) {
        preseneter.CreateComment(message: commentTF.text!)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension PostDetialsVC: UITableViewDelegate,UITableViewDataSource {
    
    func setup() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preseneter.getPostsCommentCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        preseneter.configure(cell: cell, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 202
    }

}
