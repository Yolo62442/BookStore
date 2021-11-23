//
//  ProfileViewController.swift
//  ShopApp
//
//  Created by Zhansaya on 15.06.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var myCartButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    private var presenter: ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ProfilePresenter(self)

    }
    

    @IBAction func myCartPressed(_ sender: Any) {
    }
    @IBAction func signOutPressed(_ sender: Any) {
        presenter.signOut()
    }

}

extension ProfileViewController: ProfilePresenterDelegate{
    func signOut() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
