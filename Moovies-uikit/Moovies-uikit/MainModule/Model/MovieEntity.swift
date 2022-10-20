//
//  MainModel.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 20.10.2022.
//

import Foundation

struct MovieCellViewModel {
    var title: String?
    var year: String?
    var imdbID:String?
    var poster:String?
    var type:String?
}

struct Movie: Codable {
    let search: [Search]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search
        case totalResults
        case response
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title
        case year
        case imdbID
        case type
        case poster
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}
