//
//  ViewController.swift
//  ShopApp
//
//  Created by Zhansaya on 12.06.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    private var presenter: LoginPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 4
        loginButton.layer.masksToBounds = true
        presenter = LoginPresenter(self)
    }
   
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        emailTextField.text = ""
        passwordTextField.text = ""
        presenter.loginButtonPressed(email: email, password: password)
    }
}

extension LoginViewController: LoginPresenterDelegate{
    func failedToSignIn() {
        print("Failed to login")
    }
    
    func goToMainVC() {
        self.performSegue(withIdentifier: "goToMainFromLogin", sender: nil)
    }
    
    
}

