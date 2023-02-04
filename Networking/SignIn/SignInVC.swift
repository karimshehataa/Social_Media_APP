//
//  SignInVC.swift
//  Networking
//
//  Created by karim  on 17/08/2022.
//

import UIKit

class SignInVC: UIViewController {
    var presenter: SignInPresenter?
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstNameTF.text = "koko"
        lastNameTF.text = "shehata"
        let network = Network()
        let authRepository = AuthRepository(network: network)
        presenter = SignInPresenter( authRepository: authRepository)
        firstNameLabel.isHidden = true
        lastNameLabel.isHidden = true
        firstNameTF.addTarget(self, action: #selector(firstNameDidChanged), for: .editingChanged)
        lastNameTF.addTarget(self, action: #selector(lastNameDidChanged), for: .editingChanged)
        
    }
    
    @objc func firstNameDidChanged() {
        firstNameLabel.isHidden = true
    }
    
    @objc func lastNameDidChanged() {
        lastNameLabel.isHidden = true
    }
    
    @IBAction func SignInBtn(_ sender: Any) {
        guard let firstName = firstNameTF.text, !firstName.isEmpty else {
            firstNameLabel.isHidden = false
            return
        }
        firstNameLabel.isHidden = true
        
        guard let lastName = lastNameTF.text, !lastName.isEmpty else {
            lastNameLabel.isHidden = false
            return
        }
        lastNameLabel.isHidden = true
        presenter?.getAllUsersCreated(firstName: firstName, lastName: lastName) { user, errorMessage in
            if let message = errorMessage {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true,completion: nil)
            } else {
                if let logginUser = user {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
                    self.present(vc, animated: true)
                    vc.hiLabel.isHidden = false
                    vc.addNewPostBtn.isHidden = false
                    vc.hiLabel.text = "Hi,\((logginUser.firstName)! + " " + (logginUser.lastName)!)"
                }
            }
        }
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
//        present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!) //To remove all previous UIViewController except the last one
        self.navigationController?.viewControllers = navigationArray
    }
    
    
    @IBAction func skipBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
        present(vc, animated: true)
        vc.bottomView.isHidden = true
    }
}
