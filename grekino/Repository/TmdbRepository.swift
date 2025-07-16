//
//  TmdbRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

class TmdbRepository : TmdbRepositoryProtocol {
    func getImageUrlPrefix() async throws -> String {
        let tmdbConfiguration = try await ApiService.fetchTmdbConfiguration()
        let baseImageUrl = tmdbConfiguration.images.secureBaseUrl
        let fileSize = tmdbConfiguration.images.posterSizes.first ?? "original"
        return "\(baseImageUrl)\(fileSize)"
    }
    
    func getMovieResult(imdbId: String) async throws -> TmdbMovieModel {
        let tmdbResultsModel = try await ApiService.fetchTmdbMovieResults(imdbId: imdbId)
        return tmdbResultsModel.movieResults.first!
    }
}
