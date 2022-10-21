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
    var searchBarText: String = ""
    weak var viewDelegate: MainViewModelViewProtocol?
    
    init(){
        model.delegate = self
    }
  
    
    
    func didClickItem(at index: Int) {
        let selectedItem = model.movies[index]
        print(selectedItem)
        
    }
    
    func didViewLoad() {
        //model.fetchData()
    }
    
    func getData() {
        model.searchStr = self.searchBarText
        model.fetchData()
    }

    
    func movieAtIndex(_ index: Int) -> Movie{
        return model.movies[index]
    }
    
}

private extension MainViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ movies: [Movie]) -> [MovieCellViewModel] {
        //make data usabe for view
        return movies.map { .init(title: $0.title, year: $0.year, imdbID: $0.imdbId, poster: $0.poster) }
    }
    
    
}

extension MainViewModel: MoviesModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        //data we fetch from api
        if isSuccess {
            let movies = model.movies
            let items = makeViewBasedModel(movies)
            if(items.count == 0) {
                
                viewDelegate?.showEmptyView()
            } else {
              viewDelegate?.didCellItemFetch(items)
              //viewDelegate?.hideLoadingView()
                viewDelegate?.hideEmptyView()
            }
           
        } else {
            viewDelegate?.showEmptyView()
        }


    }
    
}
