//
//  NetworkManager.swift
//  TMDB App
//
//  Created by Eden Chen on 11/12/2021.
//

import UIKit

class NetworkManager {
	
	let posterRootURL = "https://image.tmdb.org/t/p/w500"
	let apiKey = "5269d9698555638ca4df84d6fa04c4ad"
	let baseURL = "https://api.themoviedb.org/3/movie/"
	let pageURL = "&page="
	var page = 1
    let cache = NSCache<NSString, UIImage>()
    var image = UIImage()
    
    
    //dudi
    //try to make it generic and not a singelton, instead use protocol based network service & inject it to the vc that needs it on init.
    //the network manager should only send the request(any request) and give the results to the caller.
    //network should not hold the page/image etc...
    
    static let shared = NetworkManager()
	
	enum NetworkError: String, Error {
		case invalidURL = "Invalid URL please try again"
		case invalidResponse = "Invalid response please try again"
		case invalidData = "Invalid data please try again"
		case unableToComplete = "Something went wrong please try again"
	}
	
    func getMovies(urlString requestedMethod: String, page: Int, completed: @escaping (Result<[TMDBMovie], NetworkError>) -> Void) {
		
        
        let endPoint = baseURL + requestedMethod + apiKey + pageURL + "\(page)"

        print(endPoint)
		guard let url = URL(string: endPoint) else {
			completed(.failure(.invalidURL))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let _ = error {
				completed(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completed(.failure(.invalidResponse))
				return
			}

			guard let data = data else {
				completed(.failure(.invalidData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let decodedData = try decoder.decode(TMDBResponse.self, from: data)
				completed(.success(decodedData.results))
			} catch {
				completed(.failure(.unableToComplete))
			}

		}
		task.resume()
	}


    func downloadImages(from urlString: String, indexPath: IndexPath, tableView: UITableView) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else {return}
            if error != nil {return}
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return    }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
           
            DispatchQueue.main.async {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }

            
        }
        task.resume()
        
    }
	


    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
    
        if let cacheImage = cache.object(forKey: cacheKey) {
            self.image = cacheImage
            return
        }
    
    
        guard let url = URL(string: urlString) else { return }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    
    
            if error != nil {return}
    
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return    }
    
            guard let data = data else { return }
    
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
    
    
        }
        task.resume()
    }
    
}
