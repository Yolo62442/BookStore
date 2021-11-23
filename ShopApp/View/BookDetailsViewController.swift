//
//  BookDetailsViewController.swift
//  ShopApp
//
//  Created by Zhansaya on 14.06.2021.
//

import UIKit
import Kingfisher

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var reviewButton: UIButton!
    private var presenter: BookDetailsPresenter!
    
    public var ISBN: Int? {
        didSet{
            if let ISBN = ISBN{
                self.presenter = BookDetailsPresenter(self)
                self.presenter.callApiForBook(ISBN)
            }
        }
    }
    
    public var book: BookDetailsEntity.Book? {
        didSet{
            if let book = book{
                let url = "https" + book.image.dropFirst(4)
                imageView.kf.setImage(with: URL(string: url))
                self.navigationController?.navigationBar.topItem?.title = book.title
                authorLabel.text = book.author
                priceLabel.text = "\(book.price.value) " + book.price.currency
                descriptionTextView.text = book.summary
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cartButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cartButtonPressed(_ sender: Any) {
    }
    
    @IBAction func reviewButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController{
            vc.ISBN = self.book?.ISBN
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
extension BookDetailsViewController: BookDetailsPresenterDelegate{
    func callApiForBook(_ book: BookDetailsEntity.Book) {
        self.book = book
    }
    
    
}
