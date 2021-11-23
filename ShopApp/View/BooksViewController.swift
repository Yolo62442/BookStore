//
//  BooksViewController.swift
//  ShopApp
//
//  Created by Zhansaya on 14.06.2021.
//

import UIKit
import Firebase

protocol BooksProtocol: NSObjectProtocol {
    func addToCart(_ isbn: Int)
}

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var books: [BookEntity.Book] = [BookEntity.Book]() {
        didSet{
            tableView.reloadData()
        }
    }
    private var presenter: BookPresenter!
    private let cartDB = Database.database().reference().child("Cart")

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: BookTVCell.identifier, bundle: Bundle(for: BookTVCell.self)), forCellReuseIdentifier: BookTVCell.identifier)
        tableView.separatorStyle = .none
        callToPresenterFromVC()

    }
    
    func callToPresenterFromVC(){
        self.presenter = BookPresenter(self)
    }

}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "BookDetailsViewController") as? BookDetailsViewController{
            vc.ISBN = self.books[indexPath.row].ISBN
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(152)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTVCell.identifier, for: indexPath) as! BookTVCell
        cell.book = self.books[indexPath.row]
        return cell
    }
    
    
    
}

extension BooksViewController: BookPresenterDelegate{
    func callAPIForMovies(_ books: [BookEntity.Book]) {
        self.books += books
    }
}

extension BooksViewController: BooksProtocol{
    func addToCart(_ isbn: Int) {
        self.presenter.addToCart(isbn)
    }
    
    
}
