//
//  FirestoreGreatMovieRepository.swift
//  grekino
//
//  Created by Zach Freeman on 7/10/25.
//
import Foundation
import FirebaseFirestore

class FirestoreGreatMovieRepository: ObservableObject {
    private var db = Firestore.firestore()
    @Published var greatMovies: [GreatMovieModel] = [GreatMovieModel]()
    
    // Read great movies
    func getAllGreatMovies() {
        db.collection("great_movies")
            .order(by: "Name").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting great movies: \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No great movies found.")
                return
            }
            if documents.isEmpty {
                print("No great movies found.")
                return
            }
            print("got some great movies")
                self.greatMovies = documents.compactMap { snapshot -> GreatMovieModel in
                self.mapGreatMovieSnapshot(snapshot)
            }
        }
    }
    
    func getGreatMovieByVolume(volume: Int) {
        db.collection("great_movies")
            .whereField("Volume", isEqualTo: volume)
            .order(by: "SortableName").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting great movies: \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No great movies found.")
                return
            }
            if documents.isEmpty {
                print("No great movies found.")
                return
            }
            self.greatMovies = documents.compactMap { snapshot -> GreatMovieModel? in
                self.mapGreatMovieSnapshot(snapshot)
            }
        }
    }
    
    func mapGreatMovieSnapshot(_ snapshot: QueryDocumentSnapshot) -> GreatMovieModel {
        let greatMovie: GreatMovieModel
        greatMovie = try! snapshot.data(as: GreatMovieModel.self)
        return greatMovie
    }
}
