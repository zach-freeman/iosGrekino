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
    func updateUserMovieData(_ greatMovie: GreatMovieModel, review: String, starRating: Double, completion: @escaping (Result<Void, NetworkError>) -> Void)
}
