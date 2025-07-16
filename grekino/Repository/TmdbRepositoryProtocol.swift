//
//  TmdbRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

protocol TmdbRepositoryProtocol {
    func getImageUrlPrefix() async throws -> String
    func getMovieResult(imdbId: String) async throws -> TmdbMovieModel
}
