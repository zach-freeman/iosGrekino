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
}
