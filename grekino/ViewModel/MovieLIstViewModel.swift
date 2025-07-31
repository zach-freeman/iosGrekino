//
//  MovieLIstViewModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

import Combine
import Foundation

enum MovieListViewAction {
    case didAppear
    case didDetailViewAppear
    case didDetailViewDisappear
}

struct MovieListState {
    var isLoading: Bool = false
    var movies: [GreatMovieDetailModel] = []
    var didDetailViewAppear: Bool = false
    var errorMessage: String?
}

@Observable class MovieListViewModel {
    var state: MovieListState = MovieListState()
    
    private let greatMovieManager: GreatMovieManagerProtocol
    private let volume: Int
    
    init(repository: GreatMovieRepositoryProtocol, volume: Int) {
        self.greatMovieManager = GreatMovieManager(greatMovieRepository: repository)
        self.volume = volume
    }
    
    func send(action: MovieListViewAction) {
        process(action: action)
    }
}

private extension MovieListViewModel {
    func process(action: MovieListViewAction) {
        switch action {
        case .didAppear:
            print("Did Appear")
            loadMoviesForVolume(volume: volume)
        case .didDetailViewAppear:
            print("detail view appeared")
            self.state.didDetailViewAppear = true
        case .didDetailViewDisappear:
            print("detail view disappeared")
            loadMoviesForVolume(volume: volume)
        }
    }
    
    func loadMoviesForVolume(volume: Int) {
        self.state.isLoading = true
        greatMovieManager.getGreatMoviesByVolume(volume: volume) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.state.movies = movies
                case .failure(let error):
                    self?.state.errorMessage = "Error fetching movies: \(error.localizedDescription)"
                    print("Error: \(error)")
                }
                self?.state.isLoading = false
            }
        }
    }
    
}
