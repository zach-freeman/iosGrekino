//
//  MovieWatchDataViewModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/22/25.
//
import Combine
import Foundation


enum MovieWatchDataViewAction {
    case didAppear
    case didRateOneStar
    case didRateTwoStars
    case didRateThreeStars
    case didRateFourStars
}

struct MovieWatchDataState {
    var isLoading: Bool = false
    var numberOfStars: Int = 0
}

@Observable class MovieWatchDataViewModel {
    var state: MovieWatchDataState = MovieWatchDataState()
    private let userRepository: FirestoreUserRepository = FirestoreUserRepository.shared
    private let greatMovie: GreatMovieModel
    
    init(greatMovieModel: GreatMovieModel) {
        self.greatMovie = greatMovieModel
    }
    
    func send(action: MovieWatchDataViewAction) {
        process(action: action)
    }
}

private extension MovieWatchDataViewModel {
    func process(action: MovieWatchDataViewAction) {
        switch action {
        case .didAppear:
            updateState()
        case .didRateOneStar:
            print("one star rating")
            self.state.numberOfStars = 1
        case .didRateTwoStars:
            print("two star rating")
            self.state.numberOfStars = 2
        case .didRateThreeStars:
            print("three star rating")
            self.state.numberOfStars = 3
        case .didRateFourStars:
            print("four star rating")
            self.state.numberOfStars = 4
        }
    }
    
    func updateState() {
        
    }
}

