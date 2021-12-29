//
//  Endpoint.swift
//  TMDB App
//
//  Created by Eden Chen on 29/12/2021.
//

import Foundation

protocol Endpoint {
    // HTTP or HTTPS
    var scheme: String { get }
    
    // Example: "api.themoviedb.org"
    var baseURL: String { get }
    
    // "/3/movie/"
    var path: String { get }
    
    // [URLQueryItem(name: "api_key", value: API_KEY)]
    var parameters: [URLQueryItem] { get }
    
    //"GET", "POST", "PUT"...
    var method: String { get }
}
