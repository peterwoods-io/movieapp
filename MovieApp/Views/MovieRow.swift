//
//  MovieRow.swift
//  MovieApp
//
//  Created by Peter Woods on 7/19/23.
//

import SwiftUI

/// A row representing a `Movie` in the movie list.
struct MovieRow: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            MoviePosterImage(path: movie.posterPath)
                .frame(width: 100)

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.bold)

                if let formattedReleaseDate {
                    Text(formattedReleaseDate)
                        .foregroundColor(.gray)
                }
            }

            Spacer()
        }
    }
}

// MARK: Private helper members

private extension MovieRow {
    var formattedReleaseDate: String? {
        movie.releaseDate?.formatted(Date.FormatStyle().year(.defaultDigits))
    }
}

// MARK: SwiftUI Previews

struct MovieRow_Previews: PreviewProvider {
    static let previewJson = """
        {
            "id": 1620,
            "overview": "A genetically engineered assassin with deadly aim, known only as 'Agent 47' eliminates strategic targets for a top-secret organization. But when he's double-crossed, the hunter becomes the prey as 47 finds himself in a life-or-death game of international intrigue.",
            "poster_path": "/h69UJOOKlrHcvhl5H2LY74N61DQ.jpg",
            "release_date": "2007-11-21",
            "title": "Hitman",
            "vote_average": 6.082
        }
        """

    static var previewMovie: Movie = JSONMovieProvider.parseMovie(fromString: previewJson)!

    static var previews: some View {
        MovieRow(movie: previewMovie)
            .padding()
    }
}
