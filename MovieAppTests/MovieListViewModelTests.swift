//
//  MovieListViewModelTests.swift
//  MovieAppTests
//
//  Created by Peter Woods on 7/20/23.
//

import XCTest
@testable import MovieApp

/// `MovieListViewModel` tests.
@MainActor final class MovieListViewModelTests: XCTestCase {
    func testInitialState() {
        let viewModel = MovieListViewModel(movieProvider: emptyProvider)

        XCTAssertFalse(viewModel.isErrorShown)
        XCTAssertFalse(viewModel.isNoResultsShown)
    }

    func testEmptyQuery() async {
        let viewModel = MovieListViewModel(movieProvider: emptyProvider)

        await viewModel.fetchMovies(query: "")

        XCTAssertFalse(viewModel.isErrorShown)
        XCTAssertFalse(viewModel.isNoResultsShown)
    }

    func testEmptyResponse() async {
        let viewModel = MovieListViewModel(movieProvider: emptyProvider)

        await viewModel.fetchMovies(query: "Test")

        XCTAssertFalse(viewModel.isErrorShown)
        XCTAssertTrue(viewModel.isNoResultsShown)
    }

    func testErrorResponse() async {
        let viewModel = MovieListViewModel(movieProvider: errorProvider)

        await viewModel.fetchMovies(query: "Test")

        XCTAssertTrue(viewModel.isErrorShown)
        XCTAssertFalse(viewModel.isNoResultsShown)
    }

    func testValidResponse() async {
        let viewModel = MovieListViewModel(movieProvider: validProvider)

        await viewModel.fetchMovies(query: "Hitman")

        XCTAssertFalse(viewModel.isErrorShown)
        XCTAssertFalse(viewModel.isNoResultsShown)

        XCTAssertEqual(viewModel.movies.count, 3)
    }
}

private extension MovieListViewModelTests {
    var emptyProvider: MovieProvider {
        struct Provider: MovieProvider {
            func fetchMovies(searchTerm: String) async -> [Movie]? {
                return []
            }
        }

        return Provider()
    }

    var errorProvider: MovieProvider {
        struct Provider: MovieProvider {
            func fetchMovies(searchTerm: String) async -> [Movie]? {
                return nil
            }
        }

        return Provider()
    }

    var validProvider: MovieProvider {
        return JSONMovieProvider(json: JSONMovieProvider.sampleMovieList)
    }
}
