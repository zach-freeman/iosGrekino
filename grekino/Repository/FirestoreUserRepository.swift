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
            if let error = error {
                completion(.failure(.badURL))
                return
            }
            
            guard let data = snapshot?.data() else {
                completion(.failure(.noData))
                return
            }
            
            self.user = try! snapshot?.data(as: UserModel.self)
            completion(.success(self.user!))
        }
    }
}
