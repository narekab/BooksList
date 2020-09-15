//
//  List.swift
//  BooksList
//
//  Created by NB MacBook on 9/11/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import Foundation

struct List: Codable {
    
    var id: Int?
    var name: String
    var encodedName: String
    var oldDate: String?
    var newDate: String?
    var updated: String
    var image: String?
    var books: [Book]?
    
    enum CodingKeys: String, CodingKey {
        case id = "list_id"
        case name = "list_name"
        case encodedName = "list_name_encoded"
        case oldDate = "oldest_published_date"
        case newDate = "newest_published_date"
        case updated = "updated"
        case image = "list_image"
        case books = "books"
    }
    
}

struct ListsResponseData: Codable {
    var count: Int
    var results: Result?
    
    enum CodingKeys: String, CodingKey {
        case count = "num_results"
        case results = "results"
    }
}

struct Result: Codable {
    var lists: [List]?
    
    enum CodingKeys: String, CodingKey {
        case lists = "lists"
    }
}

struct NamesResponseData: Codable {
    var count: Int
    var lists: [List]?
    
    enum CodingKeys: String, CodingKey {
        case count = "num_results"
        case lists = "results"
    }
}
