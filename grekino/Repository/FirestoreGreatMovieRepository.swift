//
//  FirestoreGreatMovieRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/10/25.
//
import Foundation
import FirebaseFirestore

class FirestoreGreatMovieRepository: GreatMovieRepositoryProtocol {
    private var firestoreDatabase = Firestore.firestore()
    var greatMovies: [GreatMovieModel] = []
    
    // Read great movies
    func getAllGreatMovies(completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void) {
        firestoreDatabase.collection("great_movies")
            .order(by: "SortableName").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting great movies: \(error)")
                completion(.failure(.badURL))
                return
            }
            guard let documents = snapshot?.documents else {
                print("No great movies found.")
                completion(.failure(.badURL))
                return
            }
            if documents.isEmpty {
                print("No great movies found.")
                completion(.failure(.badURL))
                return
            }
            print("got some great movies")
            self.greatMovies = documents.compactMap { snapshot -> GreatMovieModel? in
                return self.mapGreatMovieSnapshot(snapshot)
            }
            completion(.success(self.greatMovies))
        }
    }
    
    func getGreatMovieByVolume(volume: Int, completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void) {
        firestoreDatabase.collection("great_movies")
            .whereField("Volume", isEqualTo: volume)
            .order(by: "SortableName").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting great movies: \(error)")
                completion(.failure(.badURL))
                return
            }
            guard let documents = snapshot?.documents else {
                print("No great movies found.")
                completion(.failure(.badURL))
                return
            }
            if documents.isEmpty {
                print("No great movies found.")
                completion(.failure(.badURL))
                return
            }
            self.greatMovies = documents.compactMap { snapshot -> GreatMovieModel? in
                self.mapGreatMovieSnapshot(snapshot)
            }
            completion(.success(self.greatMovies))
        }
    }
    
    func mapGreatMovieSnapshot(_ snapshot: QueryDocumentSnapshot) -> GreatMovieModel? {
        do {
            return try snapshot.data(as: GreatMovieModel.self)
        } catch {
            print("Error getting great movie from snapshot data")
            return nil
        }
    }
    
    func updateGreatMovie(_ greatMovie: GreatMovieModel, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        do {
            try firestoreDatabase.collection("great_movies").document(greatMovie.id!).setData(from: greatMovie)
        } catch {
            print("Error updating great movie: \(error)")
            completion(.failure(.badURL))
            return
        }
    }
}
