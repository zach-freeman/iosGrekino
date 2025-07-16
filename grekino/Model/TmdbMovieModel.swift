//
//  TmdbResultModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

struct TmdbMovieModel: Identifiable, Codable {
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let mediaType: String
    let genreIds: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
    }
}
