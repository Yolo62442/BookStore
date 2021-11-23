//
//  BooksPresenter.swift
//  ShopApp
//
//  Created by Zhansaya on 14.06.2021.
//

import Foundation
import CoreData
protocol BookPresenterDelegate: NSObjectProtocol {
    func callAPIForMovies(_ books: [BookEntity.Book])
}

class BookPresenter{
    
    private let networkManager: NetworkManager = NetworkManager.shared
    
    weak var controller: BookPresenterDelegate?
    private var allbooks: [BookEntity.Book] = []
    
    init(_ controller: BookPresenterDelegate){
        self.controller = controller
        callAPIForMovies()
        saveToCore()
    }
    public func addToCart(_ isbn: Int){
        let check = networkManager.addToCart(isbn)
        if check {
        //add to coredata
        }
    }
    private func callAPIForMovies(){
        networkManager.request{ [weak self] (books) -> (Void) in
            self?.controller?.callAPIForMovies(books)
            self?.allbooks = books
        }
    }
    private func saveToCore(){
        let cartBooks = networkManager.getCart()
        for book in allbooks{
            if cartBooks.contains(book.ISBN){
                //add to coredata
            }
        }
    }
}
