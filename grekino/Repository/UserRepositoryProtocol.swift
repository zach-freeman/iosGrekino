//
//  UserRepositoryProtocol.swift
//  grekino
//
//  Created by Zach Freeman on 7/21/25.
//

protocol UserRepositoryProtocol {
    func getUser(userId: String, completion: @escaping (Result<UserModel, NetworkError>) -> Void)
    func addUser(user: UserModel, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func updateUser(_ user: UserModel, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func updateUserMovieData(_ greatMovieId: String, review: String, starRating: Double, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func getMovieData(forGreatMovieId: String, completion: @escaping (Result<MovieDataModel, NetworkError>) -> Void)
}
