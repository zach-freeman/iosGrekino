//
//  TmdbRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

class TmdbRepository : TmdbRepositoryProtocol {
    func getImageUrlPrefix(completion: @escaping (Result<String, NetworkError>) -> Void) {
        ApiService.fetchTmdbConfiguration { (result) in
            switch result {
            case .success(let configuration):
                let baseImageUrl = configuration.images.secureBaseUrl
                let fileSize = configuration.images.posterSizes.first ?? "original"
                completion(.success("\(baseImageUrl)\(fileSize)"))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func getMovieResult(imdbId: String, completion: @escaping (Result<TmdbMovieModel, NetworkError>) -> Void)  {
        ApiService.fetchTmdbMovieResults(imdbId: imdbId) { (result) in
            switch result {
            case .success(let tmdbResultsModel):
                completion(.success(tmdbResultsModel.movieResults.first!))
            case .failure(let error):
                print(error)
            }
        }
    }
}
