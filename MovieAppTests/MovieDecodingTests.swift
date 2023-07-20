//
//  MovieDecodingTests.swift
//  MovieDecodingTests
//
//  Created by Peter Woods on 7/19/23.
//

import XCTest
@testable import MovieApp

/// Sanity tests for movie JSON decoding.
final class MovieDecodingTests: XCTestCase {
    func test_movieModelSanityFromJSON() async {
        let provider = JSONMovieProvider(json: JSONMovieProvider.sampleMovieList)

        guard let movies = await provider.fetchMovies(searchTerm: "Hitman") else {
            XCTFail("Unable to parse movies JSON")
            return
        }

        XCTAssertEqual(movies.count, 3)
    }
}
