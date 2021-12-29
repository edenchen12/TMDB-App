//
//  MoviesModel.swift
//  TMDB App
//
//  Created by Eden Chen on 11/12/2021.
//

import Foundation

struct TMDBResponse: Codable {
	let page: Int
	let results: [TMDBMovie]
}

struct TMDBMovie: Codable {
	
	let id: Int
	let title: String
	let posterPath: String
    let overview: String
	
}
/*
 "adult": false,
   "backdrop_path": "/lNyLSOKMMeUPr1RsL4KcRuIXwHt.jpg",
   "genre_ids": [
	 878,
	 28,
	 12
   ],
   "id": 580489,
   "original_language": "en",
   "original_title": "Venom: Let There Be Carnage",
   "overview": "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
   "popularity": 7615.279,
   "poster_path": "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
   "release_date": "2021-09-30",
   "title": "Venom: Let There Be Carnage",
   "video": false,
   "vote_average": 7.2,
   "vote_count": 4236
 
 */
