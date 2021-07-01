//
//  Data Model.swift
//  MovieDatabase
//
//  Created by Roma Test on 01.07.2021.
//

import Foundation

struct Search: Decodable {
    var search: [Movies]
    
    private enum CodingKeys : String, CodingKey {
        case search = "Search"
    }
}


struct Movies: Decodable {
    var title: String
    
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
    }
}
