//
//  BookEntity.swift
//  ShopApp
//
//  Created by Zhansaya on 13.06.2021.
//

import Foundation
struct Price: Decodable {
    let currency: String
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case value = "value"
    }
    
}
struct BookEntity: Decodable {
    let books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case books = "books"
    }
    struct Book: Decodable {
        let ISBN: Int
        let title: String
        let author: String
        let image: String
        let price: Price
        
        enum CodingKeys: String, CodingKey {
            case ISBN = "ISBN"
            case title = "title"
            case author = "author"
            case image = "image"
            case price = "price"
        }
        
    }
}
