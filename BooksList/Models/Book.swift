//
//  Book.swift
//  BooksList
//
//  Created by NB MacBook on 9/11/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import Foundation

struct Book: Codable {
    
    var title: String
    var publisher: String
    var author: String
    var rank: Int
    var description: String
    var image: String
    var links: [Link]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case publisher = "publisher"
        case author = "author"
        case rank = "rank"
        case description = "description"
        case image = "book_image"
        case links = "buy_links"
    }
    
}

struct Link: Codable {
    
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}
