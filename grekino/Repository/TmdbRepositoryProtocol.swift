//
//  TmdbRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

protocol TmdbRepositoryProtocol {
    func getImageUrlPrefix(completion: @escaping (Result<String, NetworkError>) -> Void)
    func getMovieResult(imdbId: String, completion: @escaping (Result<TmdbMovieModel, NetworkError>) -> Void)
}
