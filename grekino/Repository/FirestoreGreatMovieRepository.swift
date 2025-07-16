//
//  FirestoreGreatMovieRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/10/25.
//
import Foundation
import FirebaseFirestore

class FirestoreGreatMovieRepository: GreatMovieRepositoryProtocol {
    private var db = Firestore.firestore()
    var greatMovies: [GreatMovieModel] = []
    
    // Read great movies
    func getAllGreatMovies(completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void) {
        db.collection("great_movies")
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
                self.greatMovies = documents.compactMap { snapshot -> GreatMovieModel in
                self.mapGreatMovieSnapshot(snapshot)
            }
            completion(.success(self.greatMovies))
        }
    }
    
    func getGreatMovieByVolume(volume: Int, completion: @escaping (Result<[GreatMovieModel], NetworkError>) -> Void) {
        db.collection("great_movies")
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
    
    func mapGreatMovieSnapshot(_ snapshot: QueryDocumentSnapshot) -> GreatMovieModel {
        let greatMovie: GreatMovieModel
        greatMovie = try! snapshot.data(as: GreatMovieModel.self)
        return greatMovie
    }
}
