//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Peter Woods on 7/20/23.
//

import Foundation

/// ViewModel for `MovieListView`.
class MovieListViewModel: ObservableObject {
    /// The view model's state, indicating whether it's idle,
    /// loading, loaded, or has failed.
    enum State {
        case idle
        case loading(query: String, movies: [Movie])
        case loaded(query: String, movies: [Movie])
        case failed
    }

    @Published private(set) var state: State = .idle

    private let movieProvider: MovieProvider

    init(movieProvider: MovieProvider) {
        self.movieProvider = movieProvider
    }

    /// Fetches the movie list from the provider.
    /// The `state` property can be monitored to track changes,
    /// and all state updates will be complete when this function returns.
    func fetchMovies(query: String) async {
        guard query != currentQuery else { return }

        if query.isEmpty {
            state = .idle
            return
        }

        state = .loading(query: query, movies: movies)

        guard let queryMovies = await movieProvider.fetchMovies(searchTerm: query) else {
            state = .failed
            return
        }

        // Ensure that the data we received matches the current query,
        // otherwise discard it so that we don't end up displaying data
        // for the wrong query due to requests returning out of order.
        if query != currentQuery { return }

        state = .loaded(query: query, movies: queryMovies)
    }

    /// The list of fetched movies.
    var movies: [Movie] {
        switch state {
        case .loading(query: _, movies: let movies), .loaded(query: _, movies: let movies):
            return movies
        case .idle, .failed:
            return []
        }
    }

    /// Indicates whether the no results view should be shown.
    var isNoResultsShown: Bool {
        if case .loaded(_, let movies) = state, movies.isEmpty {
            return true
        }

        return false
    }

    /// Determines whether the error dialog should be shown.
    var isErrorShown: Bool {
        get {
            if case .failed = state {
                return true
            }

            return false
        }

        set {
            // Empty setter to allow binding to this computed value.
        }
    }
}

// MARK: Private helper members

private extension MovieListViewModel {
    /// The current query string for the loading or loaded movies, or `nil` if none exists.
    var currentQuery: String? {
        switch state {
        case .loading(query: let query, movies: _), .loaded(query: let query, movies: _):
            return query
        case .idle, .failed:
            return nil
        }
    }
}
