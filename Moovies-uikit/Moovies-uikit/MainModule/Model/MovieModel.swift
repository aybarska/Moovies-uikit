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

class PostsModel {
    weak var delegate: MoviesModelProtocol?
    var movies: [Search] = []
    
    func fetchData() {
        
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else {
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
                
                let moviesData = try jsonDecoder.decode(Movie.self, from: data)
                self?.movies = moviesData.search
                
                //self?.movies = try jsonDecoder.decode([Search].self, from: data)
                self?.delegate?.didDataFetchProcessFinish(true)
            } catch {
                self?.delegate?.didDataFetchProcessFinish(false)
            }

        }
        
        task.resume()
    }
}
