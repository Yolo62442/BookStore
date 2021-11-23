//
//  BookTVCell.swift
//  ShopApp
//
//  Created by Zhansaya on 14.06.2021.
//

import UIKit
import Kingfisher

class BookTVCell: UITableViewCell {
    
    static let identifier = "BookTVCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    public var book: BookEntity.Book? {
        didSet{
            if let book = book{
                let url = "https" + book.image.dropFirst(4)
                posterImageView.kf.setImage(with: URL(string: url))
                titleLabel.text = book.title
                authorLabel.text = book.author
                priceLabel.text = "\(book.price.value) " + book.price.currency
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.cornerRadius = 20
    }

    
}
