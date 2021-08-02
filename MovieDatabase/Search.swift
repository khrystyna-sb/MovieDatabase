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
    var poster: String?
    var title: String?
    var type: String?
    var year: String?
    var imdbID: String?
    
    private enum CodingKeys : String, CodingKey {
        case poster = "Poster"
        case title = "Title"
        case type = "Type"
        case year = "Year"
    }
}
