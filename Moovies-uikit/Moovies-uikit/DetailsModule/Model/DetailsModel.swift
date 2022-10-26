//
//  DetailsModel.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 25.10.2022.
//

import Foundation

protocol DetailsModelProtocol:AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

class DetailsModel {
    weak var delegate: DetailsModelProtocol?
    
    var detail: Detail?
   // var detail: [Detail] = []
    
    
    
    func fetchData(id: String) {
        
        guard let url = URL.init(string: "https://www.omdbapi.com/?apikey=c38cc4ed&i=\(id)") else {
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
                //print("--> data: \(String(data: data, encoding: .utf8) ?? "")")
                let detailsData = try jsonDecoder.decode(Detail.self, from: data)
                self?.detail = detailsData
                //print(self?.detail!)
                self?.delegate?.didDataFetchProcessFinish(true)
            } catch {
                print(error)
                self?.delegate?.didDataFetchProcessFinish(false)
            }

        }
        
        task.resume()
    }
}
