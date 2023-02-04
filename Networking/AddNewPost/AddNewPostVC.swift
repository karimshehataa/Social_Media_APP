//
//  AddNewPostVC.swift
//  Networking
//
//  Created by karim  on 24/08/2022.
//

import UIKit

class AddNewPostVC: UIViewController, PostView {
    func reloadTableView() {
        print("Done")
    }
    
    var presenter: AddNewPostPresenter!
    @IBOutlet weak var postTextTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let network = Network()
        let authRepository = AuthRepository(network: network)
        presenter = AddNewPostPresenter(view: self, AuthRepository: authRepository)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if let postText = postTextTF.text {
            presenter.CreatePost(text: postText)
            self.dismiss(animated: true,completion: nil)
        }
    }
}
