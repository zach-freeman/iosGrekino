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
    case didWatchMovie
}

struct MovieDetailState {
    var isLoading: Bool = true
    var posterImageUrl: String? = nil
    var description: String?
    var review: String = "I love this movie!"
    var starRating: Double = 4.0
    var errorMessage: String?
}

@Observable class MovieDetailViewModel {
    var state: MovieDetailState = MovieDetailState()
    private let tmdbRepository: TmdbRepository = TmdbRepository.shared
    private let userRepository: FirestoreUserRepository = FirestoreUserRepository.shared
    private let greatMovieRepository: GreatMovieRepositoryProtocol
    private let greatMovieDetailModel: GreatMovieDetailModel
    
    init(greatMovieRepository: GreatMovieRepositoryProtocol, greatMovieModel: GreatMovieDetailModel) {
        self.greatMovieRepository = greatMovieRepository
        self.greatMovieDetailModel = greatMovieModel
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
                print("movie has description and poster image")
                DispatchQueue.main.async { [weak self] in
                    self?.state.isLoading = true
                    self?.state.description = self?.greatMovieDetailModel.description
                    self?.state.posterImageUrl = self?.greatMovieDetailModel.posterImageUrl
                    self?.state.isLoading = false
                }
            } else {
                print("movie is missing some info")
                DispatchQueue.main.async { [weak self] in
                    self?.state.isLoading = true
                }
                fetchPosterImage()
            }
            break
        case .didWatchMovie:
            markMovieAsWatched()
            break
        }
    }
    
    func movieHasDescription() -> Bool {
        let hasDescription = self.greatMovieDetailModel.description != nil && greatMovieDetailModel.description != ""
        return hasDescription
    }
    
    func movieHasPosterImage() -> Bool {
        let hasPosterImage = greatMovieDetailModel.posterImageUrl != nil && greatMovieDetailModel.posterImageUrl != ""
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
                    self?.state.isLoading = false
                }
            }
        }
    }
    
    func fetchMovieDetails(imageUrlPrefix: String) {
        tmdbRepository.getMovieResult(imdbId: greatMovieDetailModel.imdbId) { (result) in
            switch result {
            case .success(let movieResult):
                DispatchQueue.main.async { [weak self] in
                    self?.state.description = movieResult.overview
                    self?.state.posterImageUrl = imageUrlPrefix + movieResult.posterPath!
                    self?.state.isLoading = false
                    print("i'm done")
                }
                self.updateGreatMovie(description: movieResult.overview, posterImageUrl: imageUrlPrefix + movieResult.posterPath!)
            case .failure(let error):
                if error == .noData {
                    DispatchQueue.main.async { [weak self] in
                        self?.state.description = "No description available"
                        self?.state.posterImageUrl = Constants.noImageFound
                        self?.state.isLoading = false
                    }
                    return
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.state.errorMessage = error.localizedDescription
                        self?.state.isLoading = false
                    }
                }
                
            }
        }
    }
    
    func updateGreatMovie(description: String? = nil, posterImageUrl: String? = nil) {
        var greatMovieModelCopy = GreatMovieModel(greatMovieDetailModel: greatMovieDetailModel)
        greatMovieModelCopy.description = description ?? greatMovieModelCopy.description
        greatMovieModelCopy.posterImageUrl = posterImageUrl ?? greatMovieModelCopy.posterImageUrl
        self.greatMovieRepository.updateGreatMovie(greatMovieModelCopy) { (result) in
            switch result {
            case .success:
                print("Great movie updated successfully")
                break
            case .failure(let error):
                print("Error updating great movie: \(error)")
            }
            
        }
    }
    
    func markMovieAsWatched() {
        userRepository.updateUserMovieData(self.greatMovieDetailModel.imdbId, review: self.state.review, starRating: self.state.starRating) { (result) in
            switch result {
            case .success:
                print("Great movie updated successfully")
                break
            case .failure(let error):
                print("Error updating great movie: \(error)")
            }
            
        }
    }
}
