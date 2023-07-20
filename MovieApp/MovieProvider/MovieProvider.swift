//
//  MovieProvider.swift
//  MovieApp
//
//  Created by Peter Woods on 7/19/23.
//

import Foundation

/// Protocol for interacting with a provider of movie data, such as
/// the Open Movie Database.
protocol MovieProvider {
    /// Fetch the list of movies for the provided search term.
    /// - Parameter searchTerm: The term to use when searching for movies.
    /// - Returns: A list of movies, which is empty if no results are found, or `nil`
    /// if an error occurred.
    func fetchMovies(searchTerm: String) async -> [Movie]?
}
