//
//  MovieDetailViewModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

import Combine
import Foundation

enum MovieDetailViewAction {
    case didAppear
}

struct MovieDetailState {
    var isLoading: Bool = false
    var posterUrl: String?
    var description: String?
    var errorMessage: String?
}

class MovieDetailViewModel: ObservableObject {
    @Published var state: MovieDetailState = MovieDetailState()
    private let tmdbRepository: TmdbRepositoryProtocol
    private let greatMovieModel: GreatMovieModel
    
    init(tmdbRepository: TmdbRepositoryProtocol, greatMovieModel: GreatMovieModel) {
        self.tmdbRepository = tmdbRepository
        self.greatMovieModel = greatMovieModel
    }
    
    func send(action: MovieDetailViewAction) {
        process(action: action)
    }
}

private extension MovieDetailViewModel {
    func process(action: MovieDetailViewAction) {
        switch action {
        case .didAppear:
            if greatMovieModel.description != nil && greatMovieModel.posterImageURL != nil {
                state.description = greatMovieModel.description
                state.posterUrl = greatMovieModel.posterImageURL
            } else {
                Task {
                    await fetchMovieDetails()
                }
            }
            break
        }
    }
    
    func fetchMovieDetails() async {
        do {
            let imageUrlPrefix = try await tmdbRepository.getImageUrlPrefix()
            let movieResult = try await tmdbRepository.getMovieResult(imdbId: greatMovieModel.imdbId)
            state.posterUrl = imageUrlPrefix + movieResult.posterPath!
            state.description = movieResult.overview
        } catch {
#if DEBUG
            print("Error fetching movie details: \(error)")
#endif
        }
    }
}
