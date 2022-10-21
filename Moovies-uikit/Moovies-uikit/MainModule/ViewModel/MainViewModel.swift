//
//  MainViewModel.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 20.10.2022.
//

import Foundation
protocol MainViewModelViewProtocol:AnyObject {
    func didCellItemFetch(_ items: [MovieCellViewModel])
    func showEmptyView()
    func hideEmptyView()
    func hideLoadingView()
}


class MainViewModel {
    private let model = MovieModel()
    weak var viewDelegate: MainViewModelViewProtocol?
    
    init(){
        model.delegate = self
    }
  
    
    
    func didClickItem(at index: Int) {
        let selectedItem = model.movies[index]
        print(selectedItem)
        
    }
    
    func didViewLoad() {
        model.fetchData()
    }
    
    func getData() {
        
        model.fetchData()
    }

    
    func movieAtIndex(_ index: Int) -> Search{
        return model.movies[index]
    }
    
}

private extension MainViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ movies: [Search]) -> [MovieCellViewModel] {
        //make data usabe for view
        //AYB Check this map function
//        if let hotel = hotels.first {
//            return hotel.result.map { .init(hotelNameTrans: $0.hotel_name, address: $0.address, mainPhotoURL: $0.mainPhotoURL) }
//        }
//        return []
        return movies.map { .init(title: $0.title, year: $0.year, imdbID: $0.imdbID, poster: $0.poster) }
    }
    
    
}

extension MainViewModel: MoviesModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        //data we fetch from api
      
        if isSuccess {
            let movies = model.movies
            let items = makeViewBasedModel(movies)
            viewDelegate?.didCellItemFetch(items) //this is workin on view
            viewDelegate?.hideLoadingView()
        } else {
            viewDelegate?.showEmptyView()
        }


    }
    
}
