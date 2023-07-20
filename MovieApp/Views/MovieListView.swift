//
//  MovieListView.swift
//  MovieApp
//
//  Created by Peter Woods on 7/19/23.
//

import SwiftUI

/// List view of movies with ability to search.
struct MovieListView: View {
    let movieProvider: MovieProvider

    @State var movies: [Movie] = []

    @State var searchTerm: String = ""

    var body: some View {
        List(movies) { movie in
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
            await fetchMovies(searchTerm)
        }
        .onChange(of: searchTerm) { newValue in
            Task {
                await fetchMovies(newValue)
            }
        }
        .overlay {
            if movies.isEmpty, !searchTerm.isEmpty {
                Text("No Results")
            }
        }
    }

    func fetchMovies(_ searchTerm: String) async {
        movies = await movieProvider.fetchMovies(searchTerm: searchTerm) ?? []
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
    }
}
