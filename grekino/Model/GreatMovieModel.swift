//
//  GreatMovieModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/10/25.
//
import FirebaseFirestore

struct GreatMovieModel: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var sortableName: String
    var year: Int
    var volume: Int
    var director: String
    var isCriterion: Bool
    var isWatched: Bool
    var userReview: String?
    var userStarRating: Int?
    var imdbId: String
    var posterImageURL: String?
    var genres: [String]
    var dateWatched: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "Name"
        case sortableName = "SortableName"
        case year = "Year"
        case volume = "Volume"
        case director = "Director"
        case isCriterion = "IsCriterion"
        case isWatched = "IsWatched"
        case userReview = "UserReview"
        case userStarRating = "UserStarRating"
        case imdbId = "ImdbId"
        case posterImageURL = "PosterImageURL"
        case genres = "Genres"
        case dateWatched = "DateWatched"
        case description = "Description"
    }
}
