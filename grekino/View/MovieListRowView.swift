//
//  MovieListItem.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

import SwiftUI

struct MovieListRowView: View {
    var greatMovie: GreatMovieModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(greatMovie.name).font(Font.ubuntuLarge(type: .regular))
            Text(greatMovie.director).font(Font.ubuntuMedium(type: .regular))
        }
    }
}

#Preview {
    let greatMovie = GreatMovieModel(
        name: "The Godfather",
        sortableName: "Godfather",
        year: 1972,
        volume: 1,
        director: "Francis Ford Coppola",
        isCriterion: true,
        isWatched: true,
        imdbId: "123456789",
        genres: ["drama"],
        description: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.."
    )
    MovieListRowView(greatMovie: greatMovie)
}
