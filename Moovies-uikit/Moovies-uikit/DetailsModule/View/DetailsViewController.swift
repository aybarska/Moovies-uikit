//
//  DetailsViewController.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 20.10.2022.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var posterStr: String = ""
    var imdbId: String = ""
    
    var items: Detail?
    let viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        viewModel.didViewLoad(id: self.imdbId)
        // Do any additional setup after loading the view.
        print(imdbId)
    }
}

extension DetailsViewController: DetailsViewModelViewProtocol {
    
        func didDetailItemFetch(_ item: Detail) {
            print("hi")
            self.items = item
            DispatchQueue.main.async {
                KF.url(URL(string: item.Poster ))
                    .set(to: self.posterImage)
                self.titleLabel.text = item.Title
                self.yearLabel.text = item.Year
                self.directorLabel.text = item.Director
                self.plotLabel.text = item.Plot
                
            }
            
        }
    


    }
