//
//  AuthViewModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/10/25.
//

import SwiftUI
import FirebaseAuth

@Observable class AuthViewModel {
    var user: User? = nil
    var userModel: UserModel? = nil
    var isSignedIn: Bool = false
    private let userRepository : FirestoreUserRepository = FirestoreUserRepository.shared
    
    init() {
        self.user = Auth.auth().currentUser
        self.isSignedIn = self.user != nil
        if self.isSignedIn {
            fetchUserModel()
        }
        
    }
    
    func fetchUserModel() {
        guard let uid = self.user?.uid else { return }
        UserDefaults.standard.setUserId(value: uid)
        self.userRepository.getUser(userId: uid) { (result) in
            switch result {
            case .success(let userModel):
                self.userModel = userModel
            case .failure(let error):
                print("Error fetching user: \(error)")
            }
        }
    }
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign Up Error: \(error.localizedDescription)")
                return
            }
            self.user = result?.user
            self.isSignedIn = true
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign In Error: \(error.localizedDescription)")
                return
            }
            self.user = result?.user
            self.isSignedIn = true
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isSignedIn = false
        } catch {
            print("Sign Out Error: \(error.localizedDescription)")
        }
    }
}
