//
//  FirestoreUserRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/21/25.
//
import Foundation
import FirebaseFirestore

class FirestoreUserRepository: UserRepositoryProtocol {
    private var db = Firestore.firestore()
    var user: UserModel?
    
    static let shared = FirestoreUserRepository()
    
    init() {}
    
    func getUser(userId: String, completion: @escaping (Result<UserModel, NetworkError>) -> Void) {
        db.collection("users").document(userId).getDocument { snapshot, error in
            if error != nil {
                completion(.failure(.badURL))
                return
            }
            
            guard (snapshot?.data()) != nil else {
                completion(.failure(.noData))
                return
            }
            
            self.user = try! snapshot?.data(as: UserModel.self)
            completion(.success(self.user!))
        }
    }
    
    func addUser(user: UserModel, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        do {
            let _ = try db.collection("users").addDocument(from: user)
            self.user = user
            completion(.success(()))
        }
        catch {
            print("There was an error while trying to save a task \(error.localizedDescription).")
        }
    }
    
    func updateUser(_ user: UserModel, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        print("implement me")
    }
    
    func updateUserMovieData(_ greatMovieId: String, review: String, starRating: Double, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard user != nil, let user:UserModel = user else {
            print("User not found")
            completion(.failure(.noData))
            return
        }
        let userMovieData = user.movieData.first(where: { $0.movieID == greatMovieId })
        if userMovieData != nil {
            self.user?.movieData.removeAll(where: { $0.movieID == greatMovieId })
        }
        let movieData: MovieDataModel = MovieDataModel(movieID: greatMovieId, dateWatched: Date().today(format: "yyyy-MM-dd"), isWatched: true, review: review, starRating: starRating)
        let isUserMovieUpdated = updateMovieData(movieData)
        if isUserMovieUpdated {
            completion(.success(()))
        } else {
            completion(.failure(.noData))
        }
        
    }
    
    func updateMovieData(_ movieData: MovieDataModel) -> Bool {
        guard let userId = user?.id else {
            print("User id not found")
            return false
        }
        user?.movieData.append(movieData)
        do {
            try db.collection("users").document(userId).setData(from: user)
        } catch {
            print("error when trying to update user")
            return false
        }
        return true
    }
    
    func getMovieData(forGreatMovieId greatMovieId: String, completion: @escaping (Result<MovieDataModel, NetworkError>) -> Void) {
        guard user != nil, let user:UserModel = user else {
            print("User not found")
            completion(.failure(.noData))
            return
        }
        getUser(userId: user.id ?? "") { result in
            switch result {
            case .success(let user):
                if let movieData = user.movieData.first(where: { $0.movieID == greatMovieId }) {
                    completion(.success(movieData))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
