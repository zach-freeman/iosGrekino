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
    var imdbId: String
    var posterImageUrl: String?
    var genres: [String]
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "Name"
        case sortableName = "SortableName"
        case year = "Year"
        case volume = "Volume"
        case director = "Director"
        case isCriterion = "IsCriterion"
        case imdbId = "ImdbId"
        case posterImageUrl = "PosterImageUrl"
        case genres = "Genres"
        case description = "Description"
    }
}

extension GreatMovieModel {
    init(greatMovieDetailModel: GreatMovieDetailModel) {
        id = greatMovieDetailModel.id
        name = greatMovieDetailModel.name
        sortableName = greatMovieDetailModel.sortableName
        year = greatMovieDetailModel.year
        volume = greatMovieDetailModel.volume
        director = greatMovieDetailModel.director
        isCriterion = greatMovieDetailModel.isCriterion
        imdbId = greatMovieDetailModel.imdbId
        posterImageUrl = greatMovieDetailModel.posterImageUrl
        genres = greatMovieDetailModel.genres
        description = greatMovieDetailModel.description ?? ""
    }
    
}
