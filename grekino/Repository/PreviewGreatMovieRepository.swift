//
//  PreviewGreatMovieRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

class PreviewGreatMovieRepository: GreatMovieRepositoryProtocol {
    var greatMovies: [GreatMovieModel] = []

    init() {
        greatMovies.append(PreviewData.getPreviewMovie0())
        greatMovies.append(PreviewData.getPreviewMovie1())
    }

    // Read great movies
    func getAllGreatMovies(
        completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void
    ) {
        completion(.success(greatMovies))
    }

    func getGreatMovieByVolume(
        volume: Int,
        completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void
    ) {
        completion(.success(greatMovies))
    }

}
