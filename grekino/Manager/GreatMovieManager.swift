//
//  GreatMovieManager.swift
//  grekino
//
//  Created by Zach Freeman on 7/24/25.
//

import Foundation

public class GreatMovieManager: GreatMovieManagerProtocol {
    private var greatMovieRepository: GreatMovieRepositoryProtocol
    private var userRepository: UserRepositoryProtocol = FirestoreUserRepository.shared
    var greatMovieDetails: [GreatMovieDetailModel] = []
    
    init(greatMovieRepository: GreatMovieRepositoryProtocol) {
        self.greatMovieRepository = greatMovieRepository
    }
    
    func getGreatMoviesByVolume(volume: Int, completion: @escaping (Result<[GreatMovieDetailModel], NetworkError>) -> Void) {
        self.greatMovieRepository.getGreatMovieByVolume(volume: volume) { result in
            switch result {
            case .success(let greatMovies):
                if !greatMovies.isEmpty {
                    let userId = UserDefaults.standard.getUserId() ?? ""
                    self.userRepository.getUser(userId: userId) { result in
                        switch result {
                        case .success(let user):
                            self.greatMovieDetails.removeAll()
                            for greatMovie in greatMovies {
                                if let userMovieData = user.movieData.first(where: { $0.movieID == greatMovie.id }) {
                                    let greatMovieDetailModel = GreatMovieDetailModel(greatMovie: greatMovie, userMovieData: userMovieData)
                                    self.greatMovieDetails.append(greatMovieDetailModel)
                                } else {
                                    let greatMovieDetailModel = GreatMovieDetailModel(greatMovie: greatMovie, userMovieData: nil)
                                    self.greatMovieDetails.append(greatMovieDetailModel)
                                }
                            }
                            completion(.success(self.greatMovieDetails))
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
