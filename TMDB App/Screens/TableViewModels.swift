//
//  TableViewModels.swift
//  TMDB App
//
//  Created by Eden Chen on 20/12/2021.
//

import UIKit

//dudi
//try to make viewMode the tableview datasource

class TableViewModels {
    
    var movies: [TMDBMovie] = []
    let networkManager = NetworkManager.shared
    var page = 1
    
    var isLoading = false
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    func setTableView(tableView: UITableView) {
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    
    func getMoviesToView(tableView: UITableView, endpoint: TMDBEndpoint) {
        //protocol network manager
        
        NetworkEngine.request(endpoint: endpoint) { (result: Result<TMDBResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.movies += response.results
                    print(self.movies)
                    tableView.reloadData()
                }

            case .failure(let failure):
                    print("Failure Response From Protocol ", failure)
            }
        }
//        NetworkManager.shared.getMovies(urlS    tring: methodRoot, page: networkManager.page) { result in
//            DispatchQueue.main.async { [self] in
//                switch result {
//                case .success(let movies):
//                    self.movies = movies
//
//                case .failure(let error):
//
//                    switch error {
//                    case .invalidURL:
//                        print(error.localizedDescription)
//                    case .invalidResponse:
//                        print(error.localizedDescription)
//                    case .invalidData:
//                        print(error.localizedDescription)
//                    case .unableToComplete:
//                        print(error.localizedDescription)
//                    }
//                }
//                tableView.reloadData()
//            }
//        }
    }
    
    
    func getNextPageOfMovies(tableView: UITableView, endpoint: TMDBEndpoint) {
        getMoviesToView(tableView: tableView, endpoint: endpoint)
        
//        NetworkManager.shared.getMovies(urlString: methodRoot, page: networkManager.page) { result in
//            DispatchQueue.main.async { [self] in
//
//                switch result {
//
//                case .success(let movies):
//                    self.movies += movies
//                case .failure(let error):
//                    switch error {
//
//                    case .invalidURL:
//                        print(error.localizedDescription)
//                    case .invalidResponse:
//                        print(error.localizedDescription)
//                    case .invalidData:
//                        print(error.localizedDescription)
//                    case .unableToComplete:
//                        print(error.localizedDescription)
//                    }
//                }
//                tableView.reloadData()
//
//            }
//        }
    }
    
    func getMoviesPosters(indexPath: IndexPath, tableView: UITableView, cell: MovieTableViewCell) {
        let urlString = networkManager.posterRootURL + movies[indexPath.row].posterPath
        networkManager.downloadImage(from: urlString)
    }
    
    func startLoading(view: UIView)  {
        
        isLoading = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center =  CGPoint(x:UIScreen.main.bounds.size.width / 2, y:UIScreen.main.bounds.size.height / 2)
        if let superView = view.superview {
            superView.addSubview(activityIndicator)
        }
        
        activityIndicator.startAnimating()

        
    }
    
    func stopLoading() {
        
        isLoading = false
        activityIndicator.stopAnimating()
        
    }
    
    
}


