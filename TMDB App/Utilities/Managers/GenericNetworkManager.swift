//
//  NetworkManager.swift
//  TMDB App
//
//  Created by Eden Chen on 10/12/2021.
//

import UIKit

class GenericNetworkManager {
	
	enum NetworkError: String, Error {
		case invalidURL = "Invalid URL please try again"
		case invalidResponse = "Invalid response please try again"
		case invalidData = "Invalid data please try again"
		case unableToComplete = "Something went wrong please try again"
	}

	func fetchData<Model: Decodable>(stringUrl: String, completed: @escaping (Result<[Model],NetworkError>) -> Void) {
		
		guard let url = URL(string: stringUrl) else { return completed(.failure(.invalidURL))}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			
			if let _ = error {
				completed(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200  else {
				completed(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				completed(.failure(.invalidData))
				return
			}

			do {
				let decoder = JSONDecoder()
				let decodedData = try decoder.decode([Model].self, from: data)
				DispatchQueue.main.async {
					completed(.success(decodedData))
				}

			} catch  {
				completed(.failure(.unableToComplete))
			}

		}
		task.resume()
	}
}

//    func downloadImage(from urlString: String, indexPath: IndexPath, tableView: UITableView) {
//        let cacheKey = NSString(string: urlString)
//
//        if let image = cache.object(forKey: cacheKey) {
//            self.image = image
//            return
//        }
//
//
//
//        guard let url = URL(string: urlString) else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//
//            guard let self = self else {return}
//            if error != nil {return}
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return    }
//
//            guard let data = data else { return }
//
//            guard let image = UIImage(data: data) else { return }
//            self.cache.setObject(image, forKey: cacheKey)
//            DispatchQueue.main.async {
//                self.image = image
//
//                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
//
//            }
//
//        }
//        task.resume()
//
//    }

