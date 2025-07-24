//
//  GreatMovieManagerProtocol.swift
//  grekino
//
//  Created by Zach Freeman on 7/24/25.
//

protocol GreatMovieManagerProtocol {
    func getGreatMoviesByVolume(volume: Int, completion: @escaping (Result<[GreatMovieDetailModel], NetworkError>) -> Void)
}
