//
//  ViewController.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 20.10.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MainViewModel()
        
        private var items: [MovieCellViewModel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            makeUI()
            viewModel.viewDelegate = self
            viewModel.didViewLoad()
        }
    }

    private extension MainViewController {
        func makeUI() {
            tableView.delegate = self
            tableView.dataSource = self
            registerCell()
        }
        
        func registerCell() {
            tableView.register(.init(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        }
    }

extension MainViewController: MainViewModelViewProtocol {
    func hideLoadingView() {
        //
    }
    
        
        func didCellItemFetch(_ items: [MovieCellViewModel]) {
            self.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func showEmptyView() {
            // has to be in main
            DispatchQueue.main.async {
          //  let noDataImageView = UIImageView(image: UIImage(named: "noData2"))
           //     noDataImageView.contentMode = .scaleAspectFit
           // self.tableView.backgroundView = noDataImageView
            }
        }
        
        func hideEmptyView() {
        
        }
        
    }

    extension MainViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            viewModel.didClickItem(at: indexPath.row)
            
        }
    }

    extension MainViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
            cell.titleLabel.text = items[indexPath.row].title
            cell.yearLabel.text = items[indexPath.row].year
            return cell
        }
        
    }

