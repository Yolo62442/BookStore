//
//  NetworkManager.swift
//  ShopApp
//
//  Created by Zhansaya on 13.06.2021.
//

import Foundation
import Firebase

final class NetworkManager {
    static let shared = NetworkManager()
    private let cartDB = Database.database().reference().child("Cart")
    private let reviewDB = Database.database().reference().child("Review")
    private let BooksURL = "https://private-8fd8c0-bookstore.apiary-mock.com/books"
    
    
    private init () {}
    
    func request( completion: @escaping ([BookEntity.Book]) -> (Void) ){
        let urlComponents = URLComponents(string: BooksURL)
        if let url = urlComponents?.url?.absoluteURL {
            URLSession.shared.dataTask(with: url) {  (data, response, error) in
                if error == nil {
                    if let data = data {
                        DispatchQueue.global().async {
                            do{
                                let booksJSON = try JSONDecoder().decode(BookEntity.self, from: data)
                                DispatchQueue.main.async {
                                    completion(booksJSON.books)
                                }
                            } catch let JSONError{
                                print(JSONError)
                            }
                        }
                    }
                }
            }.resume()
        }
    }
    
    func requestForBookDetails( _ isbn: Int, completion: @escaping ([BookDetailsEntity.Book]) -> (Void) ){
        let urlComponents = URLComponents(string: BooksURL)
        if let url = urlComponents?.url?.absoluteURL {
            URLSession.shared.dataTask(with: url) {  (data, response, error) in
                if error == nil {
                    if let data = data {
                        DispatchQueue.global().async {
                            do{
                                let booksJSON = try JSONDecoder().decode(BookDetailsEntity.self, from: data)
                                DispatchQueue.main.async {
                                    completion(booksJSON.books)
                                }
                            } catch let JSONError{
                                print(JSONError)
                            }
                        }
                    }
                }
            }.resume()
        }
    }
    
    func checkSignIn (email: String, password: String) -> Bool{
        var check: Bool = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                check = false
            }
        }
        CoreDataManager.shared.addUser(email, id: 1)
        return check
    }
    
    func checkSignOut () -> Bool{
        do {
            try Auth.auth().signOut()
            CoreDataManager.shared.deleteUser(with: 1)
            return true
        } catch  {
            print("Failed to log out \(error)")
            return false
        }
    }
    func signUp (email: String, password: String) -> Bool {
        var check: Bool = true
        Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
            if error != nil {
                check = false
            }
        }
        CoreDataManager.shared.addUser(email, id: 1)
        return check
    }
    
    func addToCart(_ isbn: Int) -> Bool{
        guard let email = CoreDataManager.shared.findUser(with: 1)?.email else { return false}
        let cartDict: [String: String] = ["sender": email, "isbn": "\(isbn)"]
        var check: Bool = false
        cartDB.childByAutoId().setValue(cartDict) { (error, reference) in
            if error != nil {
                print("failed to sent message, \(error!)")
            } else {
                check = true
            }
        }
        return check
    }
    func getCart() -> [Int]  {
        var cart:[Int] = []
        cartDB.observe(.childAdded) { (snapshot) in
            if let values = snapshot.value as? [String: String] {
                guard let email = values["email"] else {return }
                guard let isbn = values["isbn"] else { return }
                
                if email == CoreDataManager.shared.findUser(with: 1)?.email {
                    cart.append(Int(isbn) ?? 0)
                }
            }
        }
        return cart
    }
    func fetchReviewsFromFirebase(_ rp: ReviewPresenter, _ isbn1: Int){
       
        reviewDB.observe(.childAdded) { (snapshot) -> Void in
            var reviews:[ReviewEntity] = []
            if let values = snapshot.value as? [String: String] {
                guard let isbn = values["isbn"] else { return }
                guard let review = values["review"] else { return }
                guard let sender = values["sender"] else { return }
                if isbn1 == Int(isbn) ?? 0 {
                    reviews.append(ReviewEntity(isbn: Int(isbn) ?? 0, review: review, sender: sender))
                }
            }
            rp.reviews += reviews
        }
    }
    func sendReviewToFirebase(_ review: String, _ isbn: Int) -> Bool{
        print("here")
        guard let email = CoreDataManager.shared.findUser(with: 1)?.email else{ return false}
        let reviewDict: [String: String] = ["sender": email, "review": review, "isbn": "\(isbn)"]
        var check:Bool = true
        reviewDB.childByAutoId().setValue(reviewDict) {  (error, reference) in
            if error != nil {
                print("failed to sent message, \(error!)")
                check = false
            }
        }
        print(check)
        return check
    }
}
