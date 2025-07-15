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
}

struct MovieListState {
    var isLoading: Bool = false
    var movies: [GreatMovieModel] = []
    var errorMessage: String? = nil
}

class MovieListViewModel: ObservableObject {
    @Published var state : MovieListState = MovieListState()
    
    private let repository: GreatMovieRepository
    private let volume: Int
    
    init(repository: GreatMovieRepository, volume: Int) {
        self.repository = repository
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
            loadMoviesForVolume(volume: volume)
        }
    }
    
    func loadMoviesForVolume(volume: Int) {
        self.state.isLoading = true
        repository.getGreatMovieByVolume(volume: volume) { [weak self] result in
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
