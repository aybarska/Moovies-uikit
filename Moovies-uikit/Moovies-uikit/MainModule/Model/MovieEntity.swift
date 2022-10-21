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

//struct Movie: Decodable {
//    let search: [Search]
//    let totalResults, response: String
//
//    enum CodingKeys: String, CodingKey {
//        case search
//        case totalResults
//        case response
//    }
//}
//
//// MARK: - Search
//struct Search: Decodable {
//    let title, year, imdbID: String
//    let type: TypeEnum
//    let poster: String
//
//    enum CodingKeys: String, CodingKey {
//        case title
//        case year
//        case imdbID
//        case type
//        case poster
//    }
//}
//
//enum TypeEnum: String, Decodable {
//    case movie = "movie"
//}

//// MARK: - Welcome
//struct Movie: Decodable {
//    let search: [Search]
//}
//
//// MARK: - Result
//struct Search: Decodable {
//    let title, year, imdbID: String?
//    let poster: String?
//    let type: String?
//}

struct Movie : Codable {
    let title : String
    let year : String
    let imdbId : String
    let type : String
    let poster : String
    
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}

struct MoviesSearch : Codable {
    let movies : [Movie]?
    let Response: String?
    let totalResults: String?
    
    private enum CodingKeys : String, CodingKey {
        case movies = "Search"
        case Response = "Response"
        case totalResults = "totalResults"
    }
}


