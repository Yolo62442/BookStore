//
//  BookDetailsEntity.swift
//  ShopApp
//
//  Created by Zhansaya on 13.06.2021.
//

import Foundation


struct BookDetailsEntity: Decodable {
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
        let summary: String
        
        enum CodingKeys: String, CodingKey {
            case ISBN = "ISBN"
            case title = "title"
            case author = "author"
            case image = "image"
            case price = "price"
            case summary = "summary"
        }
    }
}
