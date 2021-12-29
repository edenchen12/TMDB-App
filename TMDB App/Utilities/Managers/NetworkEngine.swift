//
//  NetworkEngine.swift
//  TMDB App
//
//  Created by Eden Chen on 29/12/2021.
//

import Foundation

class NetworkEngine {
    
    enum ApiError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case decodingError(Error)
    }
    
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        var componets = URLComponents()
        componets.scheme = endpoint.scheme
        componets.host = endpoint.baseURL
        componets.path = endpoint.path
        componets.queryItems = endpoint.parameters
        
        guard let url = componets.url else {
            completion(.failure(ApiError.invalidURL))
            return
        }
        print("URL From Protocol: ", url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiError.invalidData))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseObject = try decoder.decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch let error {
                    completion(.failure(ApiError.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}

