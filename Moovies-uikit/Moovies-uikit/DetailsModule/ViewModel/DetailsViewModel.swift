//
//  DetailsViewModel.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 25.10.2022.
//

import Foundation

protocol DetailsViewModelViewProtocol:AnyObject {
    func didDetailItemFetch(_ item: Detail)
}


class DetailsViewModel {
    private let model = DetailsModel() // model
    var searchBarText: String = ""
    weak var viewDelegate: DetailsViewModelViewProtocol?
    
    init(){
        model.delegate = self
    }
  

    func didViewLoad(id: String) {

        model.fetchData(id: id)
    }
    

}


extension DetailsViewModel: DetailsModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        //data we fetch from api
        if isSuccess {
            let items = model.detail
            print("hi before")
            print(model.detail!)
            viewDelegate?.didDetailItemFetch(items!)
           
            
        } else {
            print("fetch failed")
        }

 
    }
    
}
