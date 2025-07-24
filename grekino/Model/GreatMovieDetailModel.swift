//
//  GreatMovieDetailModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/24/25.
//


struct GreatMovieDetailModel: Identifiable, Codable {
    var id: String?
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
    var isWatched: Bool
    var dateWatched: String?
    var review: String?
    var starRating: Double?
    
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
        case isWatched = "IsWatched"
        case dateWatched = "DateWatched"
        case review = "Review"
        case starRating = "StarRating"
    }
}

extension GreatMovieDetailModel {
    init(greatMovie: GreatMovieModel, userMovieData: MovieDataModel?) {
        id = greatMovie.id
        name = greatMovie.name
        sortableName = greatMovie.sortableName
        year = greatMovie.year
        volume = greatMovie.volume
        director = greatMovie.director
        isCriterion = greatMovie.isCriterion
        imdbId = greatMovie.imdbId
        posterImageUrl = greatMovie.posterImageUrl
        genres = greatMovie.genres
        description = greatMovie.description ?? ""
        isWatched = userMovieData?.isWatched ?? false
        dateWatched = userMovieData?.dateWatched ?? nil
        review = userMovieData?.review ?? nil
        starRating = userMovieData?.starRating ?? nil
    }
}
