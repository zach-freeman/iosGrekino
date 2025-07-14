//
//  PreviewGreatMovieRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

class PreviewGreatMovieRepository: GreatMovieRepository {
    var greatMovies: [GreatMovieModel] = []
    
    init() {
        let fakeGreatMovie0 = GreatMovieModel(id: "0", name: "The Godfather", sortableName: "Godfather", year: 1974, volume: 1, director: "Francis Ford Coppola", isCriterion: false, isWatched: true, userReview: "It was a great movie", userStarRating: 4, imdbId: "akdsjfkajsd", posterImageURL: "haldfjksadf", genres: ["drama"], dateWatched: "1984-01-01")
        let fakeGreatMovie1 = GreatMovieModel(id: "1", name: "Jaws", sortableName: "Jaws", year: 1975, volume: 1, director: "Steven Spielberg", isCriterion: false, isWatched: false, userReview: "", userStarRating: 4, imdbId: "akdsjfkajsd", posterImageURL: "haldfjksadf", genres: ["drama"], dateWatched: "1984-01-01")
        greatMovies.append(fakeGreatMovie0)
        greatMovies.append(fakeGreatMovie1)
    }
    
    // Read great movies
    func getAllGreatMovies(completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void) {
        completion(.success(greatMovies))
    }
    
    func getGreatMovieByVolume(volume: Int, completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void) {
        completion(.success(greatMovies))
    }
    
}
