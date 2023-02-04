//
//  RegisterVC.swift
//  Networking
//
//  Created by karim  on 14/08/2022.
//

import UIKit

protocol RegisterView: AnyObject {
    
    func showAlert(message: String?)
    func goToHome()
}

class RegisterVC: UIViewController,RegisterView {
    func goToHome() {
        let home = storyboard?.instantiateViewController(withIdentifier: "PostVC")
        self.present(home!, animated: true)
    }
    
    
    func showAlert(message: String?) {
        if message != nil {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true,completion: nil)
        }
        else {
            let alert = UIAlertController(title:"Success", message: "User Created", preferredStyle: .alert)
            let action = UIAlertAction(title:"Ok", style: .default) {  action in
                let vc  = self.storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
                self.present(vc, animated: true)
                vc.addNewPostBtn.isHidden = false
                vc.hiLabel.isHidden = false
                self.presenter.CreateUser(firstName: self.firstNameRF.text!, lastName: self.lastNameTF.text!, email: self.emailTF.text!)
                vc.hiLabel.text = self.firstNameRF.text
            }
            alert.addAction(action)
            self.present(alert, animated: true,completion: nil)
        }
        
    }
    
    var presenter: RegisterPresenter!
    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var firstNameRF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var firstNameView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Sign Up"
        firstNameRF.text = "xxxxz"
        lastNameTF.text = "vvvvvz"
        emailTF.text = "Emai1l@gmail.com"
        FirstNameLabel.isHidden = true
        LastNameLabel.isHidden = true
        EmailLabel.isHidden = true
        firstNameRF.addTarget(self, action: #selector(FNtextFieldDidChange), for: .editingChanged)
        lastNameTF.addTarget(self, action: #selector(LNtextFieldDidChange), for: .editingChanged)
        emailTF.addTarget(self, action: #selector(EmailtextFieldDidChange), for: .editingChanged)
        let network = Network()
        let authRepository = AuthRepository(network: network)
        presenter = RegisterPresenter(view: self, AuthRepository: authRepository)
    }
    
    @objc func FNtextFieldDidChange(textField: UITextField) {
        FirstNameLabel.isHidden = true
    }
    
    @objc func LNtextFieldDidChange(textField: UITextField) {
        LastNameLabel.isHidden = true
    }
    
    @objc func EmailtextFieldDidChange(textField: UITextField) {
        EmailLabel.isHidden = true

    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        guard let fNText = firstNameRF.text , !fNText.isEmpty else {
            FirstNameLabel.isHidden = false
            return
        }
        FirstNameLabel.isHidden = true
        guard let lNText = lastNameTF.text , !lNText.isEmpty else {
            LastNameLabel.isHidden = false
            return
        }
        LastNameLabel.isHidden = true
        guard let emailText = emailTF.text , !emailText.isEmpty else {
            EmailLabel.isHidden = false
            return
        }
        presenter.CreateUser(firstName: fNText, lastName: lNText, email: emailText)
    }
    
    
    @IBAction func signInBtn(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as? SignInVC {
            navigationController?.pushViewController(viewController, animated: true)
        }
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
    }
    
}
