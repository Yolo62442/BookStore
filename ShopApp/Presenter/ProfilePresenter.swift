//
//  ProfilePresenter.swift
//  ShopApp
//
//  Created by Zhansaya on 15.06.2021.
//

import Foundation
protocol ProfilePresenterDelegate: NSObjectProtocol {
    func signOut()
}

class ProfilePresenter{
    
    private let networkManager: NetworkManager = NetworkManager.shared
    
    weak var controller: ProfilePresenterDelegate?
    
    init(_ controller: ProfilePresenterDelegate){
        self.controller = controller
        
    }
    func signOut(){
        let check = networkManager.checkSignOut()
        if check {
            self.controller?.signOut()
        }
    }
}
