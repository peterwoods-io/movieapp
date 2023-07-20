//
//  Movie.swift
//  MovieApp
//
//  Created by Peter Woods on 7/19/23.
//

import Foundation

/// Information about a movie.
struct Movie: Decodable, Identifiable {
    /// Unique identifier.
    let id: Int

    /// The movie's title.
    let title: String

    /// A short description of the movie.
    let overview: String

    /// The movie's release date.
    let releaseDate: Date

    /// The movie's average rating.
    let rating: Float

    /// The subpath to use when loading the movie poster image.
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview

        case releaseDate = "release_date"
        case rating = "vote_average"

        case posterPath = "poster_path"
    }
}
