//
//  TmdbResultsModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

struct TmdbResultsModel: Decodable {
    let movieResults: [TmdbMovieModel]
    let personResults: [TmdbBasicModel]
    let tvResults: [TmdbBasicModel]
    let tvEpisodeResults: [TmdbBasicModel]
    let tvSeasonResults: [TmdbBasicModel]
    
    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case personResults = "person_results"
        case tvResults = "tv_results"
        case tvEpisodeResults = "tv_episode_results"
        case tvSeasonResults = "tv_season_results"
    }
}
