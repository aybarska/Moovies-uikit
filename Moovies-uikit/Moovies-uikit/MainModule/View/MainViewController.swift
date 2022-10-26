//
//  ViewController.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 20.10.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator = UIActivityIndicatorView()
    
        private let viewModel = MainViewModel()
        
        private var items: [MovieCellViewModel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            makeUI()
            setupActivityIndicator()
            viewModel.viewDelegate = self
            self.searchBar.delegate = self
            viewModel.didViewLoad()
            showWelcomeView()
        }
    
    }

    private extension MainViewController {
        func makeUI() {
            tableView.delegate = self
            tableView.dataSource = self
            registerCell()
            tableView.rowHeight = 230.0
        }
        
        func setupActivityIndicator() {
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .large
            activityIndicator.color = .red
            view.addSubview(activityIndicator)
        }
        
        func registerCell() {
            tableView.register(.init(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        }
    }

extension MainViewController: MainViewModelViewProtocol {
    
        func hideLoadingView() {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    
        
        func didCellItemFetch(_ items: [MovieCellViewModel]) {
            self.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func showEmptyView() {
            // has to be in main
            self.items = []
            DispatchQueue.main.async {
            let noDataImageView = UIImageView(image: UIImage(named: "noResult"))
                noDataImageView.contentMode = .scaleAspectFit
            self.tableView.backgroundView = noDataImageView
            self.tableView.reloadData()
            }
        }
        
        func hideEmptyView() {
            DispatchQueue.main.async {
                self.tableView.backgroundView?.isHidden = true
                self.tableView.reloadData()
            }
        }
    
    func showWelcomeView() {
        self.items = []
        DispatchQueue.main.async {
        let welcomeImageView = UIImageView(image: UIImage(named: "welcome"))
            welcomeImageView.contentMode = .scaleAspectFit
         self.tableView.backgroundView = welcomeImageView
         self.tableView.reloadData()
        }
    }
        
    }

    extension MainViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            viewModel.didClickItem(at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
            detailsVC?.imdbId = items[indexPath.row].imdbID ?? ""
            self.navigationController?.pushViewController(detailsVC!, animated: true)
        }
    }

    extension MainViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
            //Kingfisher
            cell.titleLabel.text = items[indexPath.row].title
            cell.yearLabel.text = items[indexPath.row].year
            KF.url(URL(string: items[indexPath.row].poster ?? "https://i.ibb.co/mtdQq8t/1.jpg"))
                .set(to: cell.posterImageView)
            return cell
        }
        
    }

extension MainViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
                if(searchText.count > 2){
                    self.activityIndicator.startAnimating()
                    viewModel.searchBarText = searchText
                    viewModel.getData()
                } else {
                    self.showWelcomeView()
                }

        //self.showEmptyView()
        self.tableView.reloadData()
    }
}

