//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Peter Woods on 7/19/23.
//

import SwiftUI

/// Detail view for a movie.
struct MovieDetailView: View {
    let movie: Movie

    /// The date formatter to use for the movie's release date.
    private let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()

    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 16) {
                    Image("posterPreview")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 122)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(dateFormatter.string(from: movie.releaseDate))
                            .foregroundColor(.gray)

                        VStack(alignment: .leading) {
                            Text("Viewer Rating")
                                .foregroundColor(.gray)
                            Text("\(ratingString)/10")
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                }
                
                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Overview".uppercased())
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    Text(movie.overview)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: Private helpers

private extension MovieDetailView {
    var ratingString: String {
        String(format: "%.1f", movie.rating)
    }
}

// MARK: SwiftUI Previews

struct MovieDetailView_Previews: PreviewProvider {
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
        MovieDetailView(movie: previewMovie)
    }
}
