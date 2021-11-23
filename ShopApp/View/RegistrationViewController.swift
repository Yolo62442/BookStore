//
//  RegistrationViewController.swift
//  ShopApp
//
//  Created by Zhansaya on 13.06.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registrationButton: UIButton!
    private var presenter: RegistrationPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registrationButton.layer.cornerRadius = 4
        registrationButton.layer.masksToBounds = true
        presenter = RegistrationPresenter(self)
    }
   
    @IBAction func registrationButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        presenter.registerButtonPressed(email: email, password: password)
    }

}

extension RegistrationViewController: RegistrationPresenterDelegate{
    func failedToSignUp() {
        print("Failed to sign up")
    }
    
    func goToMainVC() {
        self.performSegue(withIdentifier: "goToMainFromRegistration", sender: nil)
    }
    
    
}
