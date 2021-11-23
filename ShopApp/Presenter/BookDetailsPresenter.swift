//
//  BookDetailsPresenter.swift
//  ShopApp
//
//  Created by Zhansaya on 15.06.2021.
//

import Foundation
protocol BookDetailsPresenterDelegate: NSObjectProtocol {
    func callApiForBook(_ book: BookDetailsEntity.Book)
}

class BookDetailsPresenter{
    
    private let networkManager: NetworkManager = NetworkManager.shared
    
    weak var controller: BookDetailsPresenterDelegate?
    
    init(_ controller: BookDetailsPresenterDelegate){
        self.controller = controller
    }
    
    public func callApiForBook(_ isbn: Int){
        networkManager.requestForBookDetails(isbn){ [weak self] (books) -> (Void) in
            for book in books{
                if book.ISBN == isbn{
                    self?.controller?.callApiForBook(book)
                }
            }
        }
    }
}
