//
//  ApiService.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

import Foundation

class ApiService {
    static func fetchTmdbConfiguration(completion: @escaping (Result<TmdbConfigurationModel, NetworkError>) -> Void) {
        let url = URL(string: "\(ApiConstants.baseUrl)\(ApiConstants.configurationEndpoint)?api_key=\(ApiKeys.tmdbApiKey)")!
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(.failure(.badURL))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tmdbConfiguration = try JSONDecoder().decode(TmdbConfigurationModel.self, from: data)
                completion(.success(tmdbConfiguration))
            } catch let error {
                print(error)
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    static func fetchTmdbMovieResults(imdbId: String, completion: @escaping (Result<TmdbResultsModel, NetworkError>) -> Void) {
        let url = URL(string: "\(ApiConstants.baseUrl)\(ApiConstants.findEndpoint)/tt\(imdbId)?external_source=imdb_id&api_key=\(ApiKeys.tmdbApiKey)")
        URLSession.shared.dataTask(with: url!) { (data, _, error) in
            if let error = error {
                print(error)
                completion(.failure(.badURL))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tmdbResults = try JSONDecoder().decode(TmdbResultsModel.self, from: data)
                completion(.success(tmdbResults))
            } catch let error {
                print(error)
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
