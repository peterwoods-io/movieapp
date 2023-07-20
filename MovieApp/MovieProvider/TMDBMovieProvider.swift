//
//  TMDBMovieProvider.swift
//  MovieApp
//
//  Created by Peter Woods on 7/20/23.
//

import Foundation

class TMDBMovieProvider: MovieProvider {
    func fetchMovies(searchTerm: String) async -> [Movie]? {
        guard let url = createUrl(searchTerm: searchTerm) else {
            return nil
        }

        print("URL: \(url.absoluteString)")

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            return JSONMovieProvider.parseMovies(fromResponseData: data)
        } catch {
            return nil
        }
    }
}

private extension TMDBMovieProvider {
    enum Constants {
        static let movieSearchUrl = "https://api.themoviedb.org/3/search/movie"
        static let apiKey = "b11fc621b3f7f739cb79b50319915f1d"
    }

    func createUrl(searchTerm: String) -> URL? {
        guard var components = URLComponents(string: Constants.movieSearchUrl) else {
            return nil
        }

        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "query", value: searchTerm),
        ]

        return components.url
    }
}
