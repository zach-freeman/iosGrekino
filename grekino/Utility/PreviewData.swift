//
//  PreviewData.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

struct PreviewData {
    static func getPreviewMovie0 () -> GreatMovieModel {
        return GreatMovieModel(
            id: "0",
            name: "The Godfather",
            sortableName: "Godfather",
            year: 1972,
            volume: 1,
            director: "Francis Ford Coppola",
            isCriterion: false,
            isWatched: true,
            userReview: "It was a great movie",
            userStarRating: 4,
            imdbId: "akdsjfkajsd",
            posterImageURL: "https://image.tmdb.org/t/p/w92/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
            genres: ["drama"],
            dateWatched: "1984-01-01",
            description: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge."
        )
    }
    
    static func getPreviewMovie1 () -> GreatMovieModel {
        return GreatMovieModel(
            id: "1",
            name: "Jaws",
            sortableName: "Jaws",
            year: 1975,
            volume: 1,
            director: "Steven Spielberg",
            isCriterion: false,
            isWatched: false,
            userReview: "",
            userStarRating: 4,
            imdbId: "akdsjfkajsd",
            posterImageURL: "haldfjksadf",
            genres: ["drama"],
            dateWatched: "1984-01-01",
            description: "When the seaside community of Amity finds itself under attack by a dangerous great white shark, the town's chief of police, a young marine biologist, and a grizzled hunter embark on a desperate quest to destroy the beast before it strikes again."
        )
    }
}
