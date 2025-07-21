//
//  UserRepositoryProtocol.swift
//  grekino
//
//  Created by Zach Freeman on 7/21/25.
//

protocol UserRepositoryProtocol {
    func getUser(userId: String, completion: @escaping (Result<UserModel, NetworkError>) -> Void)
}
