//
//  JSONMovieProvider.swift
//  MovieApp
//
//  Created by Peter Woods on 7/19/23.
//

import Foundation

/// A `MovieProvider` implementation which works with JSON strings,
/// usable for testing and previews.
struct JSONMovieProvider: MovieProvider {
    let movies: [Movie]?

    init(json: String) {
        movies = Self.parseMovies(fromString: json)
    }

    func fetchMovies(searchTerm: String) async -> [Movie]? {
        guard let movies else { return nil }

        return movies.filter({ $0.title.localizedCaseInsensitiveContains(searchTerm) })
    }
}

// MARK: Static methods

extension JSONMovieProvider {
    /// Parse a movies list from a string JSON representation.
    /// - Parameter json: JSON string representation of a list of movies.
    /// - Returns: The parsed list of movies, or `nil` if parsing failed.
    static func parseMovies(fromString json: String) -> [Movie]? {
        guard let jsonData = json.data(using: .utf8) else {
            assertionFailure("Invalid JSON string")
            return nil
        }

        do {
            return try jsonDecoder.decode([Movie].self, from: jsonData)
        } catch {
            return nil
        }
    }
}

// MARK: JSON decoding configuration

private extension JSONMovieProvider {
    /// Creates a `DateFormatter` instance to use for JSON decoding.
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    /// Creates a `JSONDecoder` instance preconfigured for decoding.
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}

// MARK: Test/preview sample data

#if DEBUG
extension JSONMovieProvider {
    static let sampleMovieList = """
        [
            {
                "adult": false,
                "backdrop_path": "/lkoI9rc3OhuSYSy7gK45a3Nk9HH.jpg",
                "genre_ids":
                [
                    28,
                    53,
                    18
                ],
                "id": 1620,
                "original_language": "en",
                "original_title": "Hitman",
                "overview": "A genetically engineered assassin with deadly aim, known only as 'Agent 47' eliminates strategic targets for a top-secret organization. But when he's double-crossed, the hunter becomes the prey as 47 finds himself in a life-or-death game of international intrigue.",
                "popularity": 37.064,
                "poster_path": "/h69UJOOKlrHcvhl5H2LY74N61DQ.jpg",
                "release_date": "2007-11-21",
                "title": "Hitman",
                "video": false,
                "vote_average": 6.082,
                "vote_count": 2967
            },
            {
                "adult": false,
                "backdrop_path": "/qHLkjbHOcbtfBiMi7nFTE8fbqWr.jpg",
                "genre_ids":
                [
                    28,
                    80
                ],
                "id": 323966,
                "original_language": "en",
                "original_title": "A Hitman in London",
                "overview": "After his last assignment ended with the death of an innocent woman, a hitman's new job in London is compromised when he is overcome with guilt, and ends up helping a desperate woman who is caught up in a human trafficking operation.",
                "popularity": 11.558,
                "poster_path": "/4xy9mg9c1YW38kBKLLA8AoaUs7s.jpg",
                "release_date": "2015-03-12",
                "title": "A Hitman in London",
                "video": false,
                "vote_average": 4.4,
                "vote_count": 35
            },
            {
                "adult": false,
                "backdrop_path": "/7V9diNdJSP1sDBURTVEFS4OiROH.jpg",
                "genre_ids":
                [
                    80,
                    18,
                    28
                ],
                "id": 633951,
                "original_language": "fr",
                "original_title": "Confessions",
                "overview": "A paid assassin working for the biker gangs of Quebec outsmarts both the police and the underworld for decades, committing 28 hits over 25 years.",
                "popularity": 7.014,
                "poster_path": "/sFGkKtWq9rvb7AriX39369FRssP.jpg",
                "release_date": "2022-07-20",
                "title": "Confessions of a Hitman",
                "video": false,
                "vote_average": 6.643,
                "vote_count": 21
            },
        ]
        """
}
#endif
