//
//  GreatMovieRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

protocol GreatMovieRepositoryProtocol {
    func getAllGreatMovies(completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void)
    func getGreatMovieByVolume(volume: Int, completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void)
}
