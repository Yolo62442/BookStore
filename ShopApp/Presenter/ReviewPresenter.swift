//
//  ReviewPresenter.swift
//  ShopApp
//
//  Created by Zhansaya on 15.06.2021.
//

import Foundation
protocol ReviewPresenterDelegate: NSObjectProtocol {
    func fetchReviewsFromFirebase(_ reviews: [ReviewEntity])
    func sendReviewToFirebase()
}

class ReviewPresenter{
    
    private let networkManager: NetworkManager = NetworkManager.shared
    public var reviews: [ReviewEntity] = []{
        didSet{
            self.fetchReviewsFromFirebase()
        }
    }
    
    weak var controller: ReviewPresenterDelegate?
    
    init(_ controller: ReviewPresenterDelegate, isbn: Int){
        self.controller = controller
        networkManager.fetchReviewsFromFirebase(self, isbn)
    }
 
    func sendReviewsToFirebase(_ review: String, _ isbn: Int){
        let check = networkManager.sendReviewToFirebase(review, isbn)
        if check {
            self.controller?.sendReviewToFirebase()
        }
    }
    private func fetchReviewsFromFirebase(){
        self.controller?.fetchReviewsFromFirebase(reviews)
    }
}
