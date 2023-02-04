//
//  ViewController.swift
//  Networking
//
//  Created by karim  on 07/08/2022.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

protocol PostView:BaseViewProtocol {
    func reloadTableView()
}

class PostVC: UIViewController {
    let pullControl = UIRefreshControl()
    var presenter: PostPresenter!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var addNewPostBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pullControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        pullControl.addTarget(self, action: #selector(pulledRefreshControl), for:.valueChanged)
           tableView.addSubview(pullControl)
        hiLabel.isHidden = true
        addNewPostBtn.isHidden = true
        setupTableView()
        let network = Network()
        let authRepository = AuthRepository(network: network)
        self.presenter = PostPresenter(view: self, AuthRepository: authRepository, posts: [])
    }

    
    override func viewDidAppear(_ animated: Bool) {
        pullControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        pullControl.addTarget(self, action: #selector(pulledRefreshControl), for:.valueChanged)
           tableView.addSubview(pullControl)
        self.presenter.posts = []
//        self.presenter.total = 0
        self.presenter.getPosts()
//        self.tableView.reloadData()
    }
    
    @objc func pulledRefreshControl() {
        pullControl.endRefreshing()
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addNewPost(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "AddNewPostVC") as! AddNewPostVC
        present(vc, animated: true)
    }
}

extension PostVC: UITableViewDelegate,UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPostsCounts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        presenter.configure(cell: cell, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 437
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostDetialsVC") as! PostDetialsVC
        let post = presenter.didSelectRow(index: indexPath.row)
        let network = Network()
        let repository = AuthRepository(network: network)
        let detialsPresenter = PostDetailsPresenter(view: vc, postData: post, AuthRepository: repository)
        vc.preseneter = detialsPresenter
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.getPostsCounts() - 1 && presenter.getPostsCounts() < presenter.total{
            presenter.page = presenter.page + 1
            presenter.getPosts()
        }
    }
}

extension PostVC: PostView {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showIndicator() {
        loaderView.startAnimating()
    }
    
    func hideIndicator() {
        loaderView.stopAnimating()
    }
    
}

