//
//  MovieListView.swift
//  MovieApp
//
//  Created by Peter Woods on 7/19/23.
//

import SwiftUI

/// List view of movies with ability to search.
struct MovieListView: View {
    @StateObject var viewModel: MovieListViewModel

    @State var searchTerm: String

    init(movieProvider: MovieProvider, searchTerm: String = "") {
        self._viewModel = StateObject(wrappedValue: MovieListViewModel(movieProvider: movieProvider))
        self.searchTerm = searchTerm
    }

    var body: some View {
        List(viewModel.movies) { movie in
            NavigationLink {
                MovieDetailView(movie: movie)
            } label: {
                MovieRow(movie: movie)
            }
        }
        .navigationTitle("Movie Search")
        .listStyle(.plain)
        .searchable(text: $searchTerm)
        .task {
            await viewModel.fetchMovies(query: searchTerm)
        }
        .onChange(of: searchTerm) { newValue in
            fetchMovies(query: newValue)
        }
        .overlay {
            if viewModel.isNoResultsShown {
                Text("No Results")
            }
        }
        .alert("An error occurred while loading movie data", isPresented: $viewModel.isErrorShown) {
            Button("Cancel", role: .cancel) {}
            
            Button("Retry") {
                fetchMovies(query: searchTerm)
            }
        }
    }

    /// Fetch movies based on the provided query string.
    /// - Parameter query: The query string to use in the movie search.
    func fetchMovies(query: String) {
        Task {
            await viewModel.fetchMovies(query: query)
        }
    }
}

// MARK: SwiftUI Previews

struct MovieListView_Previews: PreviewProvider {
    static let movieProvider = JSONMovieProvider(json: JSONMovieProvider.sampleMovieList)

    static var previews: some View {
        NavigationStack {
            MovieListView(movieProvider: movieProvider, searchTerm: "Hitman")
        }
        .previewDisplayName("Sample Data")

        NavigationStack {
            MovieListView(movieProvider: TMDBMovieProvider(), searchTerm: "Hitman")
        }
        .previewDisplayName("Live Data")

        NavigationStack {
            MovieListView(movieProvider: ErrorProvider(), searchTerm: "Hitman")
        }
        .previewDisplayName("Error")
    }

    struct ErrorProvider: MovieProvider {
        func fetchMovies(searchTerm: String) async -> [Movie]? {
            return nil
        }
    }
}
