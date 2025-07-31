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
    case didSave
    case didUpdateDateWatched
}

struct MovieWatchDataState {
    var isLoading: Bool = false
    var numberOfStars: Int = 0
    var isMovieWatched: Bool = false
    var reviewText: String = ""
    var dateWatched: String = Date().today(format: "MMM dd, yyyy")
    var dateWatchedDate: Date = Date()
}

@Observable class MovieWatchDataViewModel {
    var state: MovieWatchDataState = MovieWatchDataState()
    private let userRepository: FirestoreUserRepository =
        FirestoreUserRepository.shared
    private let greatMovie: GreatMovieDetailModel

    init(greatMovieModel: GreatMovieDetailModel) {
        self.greatMovie = greatMovieModel
    }

    func setDateWatched(_ date: Date) {
        self.state.dateWatchedDate = date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.state.dateWatched = formatter.string(from: date)
    }

    func send(action: MovieWatchDataViewAction) {
        process(action: action)
    }
}

extension MovieWatchDataViewModel {
    fileprivate func process(action: MovieWatchDataViewAction) {
        switch action {
        case .didAppear:
            initializeMovieData()
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
        case .didSave:
            updateMovieData()
        case .didUpdateDateWatched:

            print(self.state.dateWatched)
        }
    }

    fileprivate func initializeMovieData() {
        userRepository.getMovieData(forGreatMovieId: self.greatMovie.id ?? "") { [weak self] result in
            switch result {
            case .success(let movieData):
                self?.state.isMovieWatched = movieData.isWatched
                self?.state.numberOfStars = movieData.starRating?.toInt() ?? 0
                self?.state.reviewText = movieData.review ?? ""
                self?.state.dateWatched = movieData.dateWatched
            case .failure:
                break
            }
        }
    }

    fileprivate func updateMovieData() {
        guard let greatMovieId = self.greatMovie.id else { return }
        userRepository.updateUserMovieData(
            greatMovieId,
            dateWatched: self.state.dateWatched,
            review: self.state.reviewText,
            starRating: self.state.numberOfStars.doubleValue
        ) { [weak self] result in
            switch result {
            case .success:
                print("successfully updated movie data")
            case .failure:
                print("failed to update movie data")
            }
        }
    }
}
