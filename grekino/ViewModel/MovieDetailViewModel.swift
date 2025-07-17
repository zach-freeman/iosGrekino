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
    var isLoading: Bool = true
    var posterImageUrl: String? = nil
    var description: String?
    var errorMessage: String?
}

@Observable class MovieDetailViewModel {
    var state: MovieDetailState = MovieDetailState()
    private let tmdbRepository: TmdbRepository = TmdbRepository.shared
    private let greatMovieRepository: GreatMovieRepositoryProtocol
    private let greatMovieModel: GreatMovieModel
    
    init(greatMovieRepository: GreatMovieRepositoryProtocol, greatMovieModel: GreatMovieModel) {
        self.greatMovieRepository = greatMovieRepository
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
                print("movie has description and poster image")
                DispatchQueue.main.async { [weak self] in
                    self?.state.isLoading = true
                    self?.state.description = self?.greatMovieModel.description
                    self?.state.posterImageUrl = self?.greatMovieModel.posterImageURL
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
                    self?.state.isLoading = false
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
        var greatMovieModelCopy = self.greatMovieModel
        greatMovieModelCopy.description = description
        greatMovieModelCopy.posterImageURL = posterImageUrl
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
}
