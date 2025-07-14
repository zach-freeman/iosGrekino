//
//  MovieLIstViewModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [GreatMovieModel] = []
    
    private let repository: GreatMovieRepository
    
    init(repository: GreatMovieRepository) {
        self.repository = repository
    }
    
    func loadMoviesForVolume(volume: Int) {
        repository.getGreatMovieByVolume(volume: volume) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
