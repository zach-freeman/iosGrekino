//
//  TmdbRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

class TmdbRepository : TmdbRepositoryProtocol {
    var baseImageUrl : String = ""
    var fileSize : String = ""
    
    static let shared = TmdbRepository()
    
    init() {}
    
    func getImageUrlPrefix(completion: @escaping (Result<String, NetworkError>) -> Void) {
        if baseImageUrl.isEmpty && fileSize.isEmpty {
            ApiService.fetchTmdbConfiguration { (result) in
                switch result {
                case .success(let configuration):
                    self.baseImageUrl = configuration.images.secureBaseUrl
                    self.fileSize = configuration.images.posterSizes.first ?? "original"
                    completion(.success("\(self.baseImageUrl)\(self.fileSize)"))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success("\(self.baseImageUrl)\(self.fileSize)"))
        }

    }
    
    func getMovieResult(imdbId: String, completion: @escaping (Result<TmdbMovieModel, NetworkError>) -> Void)  {
        ApiService.fetchTmdbMovieResults(imdbId: imdbId) { (result) in
            switch result {
            case .success(let tmdbResultsModel):
                if let tmdbMovieModel = tmdbResultsModel.movieResults.first {
                    completion(.success(tmdbMovieModel))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(_):
                completion(.failure(.badURL))
            }
        }
    }
}
