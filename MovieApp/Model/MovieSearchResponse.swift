//
//  MovieSearchResponse.swift
//  MovieApp
//
//  Created by Peter Woods on 7/20/23.
//

import Foundation

/// The response object from a movie search on TMDB.
struct MovieSearchResponse: Decodable {
    let results: [Movie]
}
