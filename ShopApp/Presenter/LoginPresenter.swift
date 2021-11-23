//
//  LoginPresenter.swift
//  ShopApp
//
//  Created by Zhansaya on 13.06.2021.
//

import Foundation
protocol LoginPresenterDelegate: NSObjectProtocol {
    func failedToSignIn()
    func goToMainVC()
}

class LoginPresenter{
    
    private let networkManager: NetworkManager = NetworkManager.shared
    
    weak var controller: LoginPresenterDelegate?
    
    init(_ controller: LoginPresenterDelegate){
        self.controller = controller
        
    }
    func loginButtonPressed(email: String, password: String){
        let check = networkManager.checkSignIn(email: email, password: password)
        if check {
            self.controller?.goToMainVC()
        }else{
            self.controller?.failedToSignIn()
        }
    }
}
