//
//  Movie.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 10.04.2022.
//

import Foundation

struct MovieResponseModel: Codable {
    let movies: [Movie]?
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

struct Movie: Codable {
    let name: String?
    let year: String?
    let imageUrlStr: String?
    let type: String?
    let imdbID: String?
    private enum CodingKeys: String, CodingKey {
        case name = "Title"
        case year = "Year"
        case imageUrlStr = "Poster"
        case type = "Type"
        case imdbID
    }
}
