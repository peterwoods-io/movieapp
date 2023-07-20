//
//  MovieApp.swift
//  MovieApp
//
//  Created by Peter Woods on 7/19/23.
//

import SwiftUI

@main
struct MovieApp: App {
    var movieProvider = JSONMovieProvider(json: JSONMovieProvider.sampleMovieList)

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListView(movieProvider: movieProvider)
            }
        }
    }
}
