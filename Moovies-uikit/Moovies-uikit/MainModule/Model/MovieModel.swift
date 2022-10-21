//
//  MovieModel.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 20.10.2022.
//

import Foundation

protocol MoviesModelProtocol:AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

class MovieModel {
    weak var delegate: MoviesModelProtocol?
    var movies: [Movie] = []
    var searchStr: String = ""
    
    func fetchData() {
        
        guard let url = URL.init(string: "https://www.omdbapi.com/?apikey=c38cc4ed&s=\(searchStr)") else {
            delegate?.didDataFetchProcessFinish(false)
            return
        }
        
        
        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        
           let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
           
            guard error == nil
               else {
                self?.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            guard let data = data else {
                self?.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let moviesData = try jsonDecoder.decode(MoviesSearch.self, from: data)
                
                if(moviesData.Response == "False") {
                    print("false")
                    self?.movies = []
                } else {
                    self?.movies = moviesData.movies!
                }
                
                self?.delegate?.didDataFetchProcessFinish(true)
            } catch {
                self?.delegate?.didDataFetchProcessFinish(false)
            }

        }
        
        task.resume()
    }
}
