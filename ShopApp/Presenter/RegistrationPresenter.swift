//
//  RegistrationPresenter.swift
//  ShopApp
//
//  Created by Zhansaya on 13.06.2021.
//

import Foundation
protocol RegistrationPresenterDelegate: NSObjectProtocol {
    func failedToSignUp()
    func goToMainVC()
}

class RegistrationPresenter{
    
    private let networkManager: NetworkManager = NetworkManager.shared
    
    weak var controller: RegistrationPresenterDelegate?
    
    init(_ controller: RegistrationPresenterDelegate){
        self.controller = controller
        
    }
    func registerButtonPressed(email: String, password: String){
        let check = networkManager.checkSignIn(email: email, password: password)
        if check {
            self.controller?.goToMainVC()
        }else{
            self.controller?.failedToSignUp()
            
        }
    }
}
