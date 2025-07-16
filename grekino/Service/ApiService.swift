//
//  ApiService.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

import Foundation

class ApiService {
    static func fetchTmdbConfiguration() async throws -> TmdbConfigurationModel {
        let url = URL(string: "\(ApiConstants.baseUrl)\(ApiConstants.configurationEndpoint)?api_key=\(ApiKeys.tmdbApiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(TmdbConfigurationModel.self, from: data)
        return decoded
    }
    
    static func fetchTmdbMovieResults(imdbId: String) async throws -> TmdbResultsModel {
        let url = URL(string: "\(ApiConstants.baseUrl)\(ApiConstants.findEndpoint)/tt\(imdbId)?external_source=imdb_id&api_key=\(ApiKeys.tmdbApiKey)")
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoded = try JSONDecoder().decode(TmdbResultsModel.self, from: data)
        return decoded
    }
}
