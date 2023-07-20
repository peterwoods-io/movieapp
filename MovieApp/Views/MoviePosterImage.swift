//
//  MoviePosterImage.swift
//  MovieApp
//
//  Created by Peter Woods on 7/20/23.
//

import SwiftUI

/// Poster image for a movie, built using the TMDB poster path.
struct MoviePosterImage: View {
    let path: String?

    var body: some View {
        AsyncImage(url: asyncImageUrl) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.gray
                .aspectRatio(0.66667, contentMode: .fit)
        }
    }
}

// MARK: Private members

private extension MoviePosterImage {
    enum Constants {
        static let basePosterUrl = "https://image.tmdb.org/t/p/original"
    }

    var asyncImageUrl: URL? {
        guard let path, !path.isEmpty else { return nil }

        return URL(string: "\(Constants.basePosterUrl)\(path)")
    }
}

// MARK: SwiftUI Previews

struct MoviePosterImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MoviePosterImage(path: "/42ek8DiVfYuHqCKJHPuOiF6RUCn.jpg")
            MoviePosterImage(path: "/2348234u234.doesntwork")
            MoviePosterImage(path: "")
            MoviePosterImage(path: nil)
        }
    }
}
