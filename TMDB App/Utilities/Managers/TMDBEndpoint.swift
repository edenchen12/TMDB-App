//
//  TMDBEndpoint.swift
//  TMDB App
//
//  Created by Eden Chen on 29/12/2021.
//

import Foundation

//MARK: - TMDB Endpoint

enum TMDBEndpoint: Endpoint {
    case getPopularsMovies(page: Int)
    case getNowPlayingMovies(page: Int)
    case getTopRatedMovies(page: Int)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "api.themoviedb.org"
        }
    }
    
    
    var path: String {
        switch self {
        case .getPopularsMovies:
        return "/3/movie/popular"
        case .getNowPlayingMovies:
        return "/3/movie/now_playing"
        case .getTopRatedMovies:
        return "/3/movie/top_rated"
        }
    }
    
    var parameters: [URLQueryItem] {
        //Disclaimer: for simplicity's sake
        let apiKey = "5269d9698555638ca4df84d6fa04c4ad"
        
        switch self {
        case .getPopularsMovies(let page):
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: String(page))]
        case .getNowPlayingMovies(let page):
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: String(page))]
        case .getTopRatedMovies(let page):
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: String(page))]
        }
    }
    
    var method: String {
        switch self {
        case .getPopularsMovies:
            return "GET"
        case .getNowPlayingMovies:
            return "GET"
        case .getTopRatedMovies:
            return "GET"
        }
    }
    
    
}
