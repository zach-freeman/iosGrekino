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
    var year: Int
    var volume: Int
    var director: String
    var isCriterion: Bool
    var isWatched: Bool
    var userReview: String?
    var userStarRating: Int?
    var imdbId: String
    var posterImageURL: String?
}
