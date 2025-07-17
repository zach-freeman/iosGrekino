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
    var posterImageUrl: String? = nil
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
            if movieHasDescription() && movieHasPosterImage()
            {
                DispatchQueue.main.async { [weak self] in
                    self?.state.description = self?.greatMovieModel.description
                    self?.state.posterImageUrl = self?.greatMovieModel.posterImageURL
                }
            } else {
                fetchPosterImage()
            }
            break
        }
    }
    
    func movieHasDescription() -> Bool {
        let hasDescription = self.greatMovieModel.description != nil && greatMovieModel.description != ""
        return hasDescription
    }
    
    func movieHasPosterImage() -> Bool {
        let hasPosterImage = greatMovieModel.posterImageURL != nil && greatMovieModel.posterImageURL != ""
        return hasPosterImage
    }
    
    func fetchPosterImage() {
        tmdbRepository.getImageUrlPrefix() { (result) in
            switch result {
            case .success(let imageUrlPrefix):
                self.fetchMovieDetails(imageUrlPrefix: imageUrlPrefix)
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.state.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchMovieDetails(imageUrlPrefix: String) {
        tmdbRepository.getMovieResult(imdbId: greatMovieModel.imdbId) { (result) in
            switch result {
            case .success(let movieResult):
                DispatchQueue.main.async { [weak self] in
                    self?.state.description = movieResult.overview
                    self?.state.posterImageUrl = imageUrlPrefix + movieResult.posterPath!
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.state.errorMessage = error.localizedDescription
                }
                
            }
        }
        
    }
}
