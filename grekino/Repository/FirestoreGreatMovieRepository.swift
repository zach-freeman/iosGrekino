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
        db.collection("great_movies").order(by: "Name").addSnapshotListener { snapshot, error in
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
            self.greatMovies = documents.map { snapshot -> GreatMovieModel in
                let data = snapshot.data()
                return GreatMovieModel(
                    id: snapshot.documentID,
                    name: data["Name"] as! String,
                    year: data["Year"] as! Int,
                    volume: data["Volume"] as! Int,
                    director: data["Director"] as! String,
                    isCriterion: data["IsCriterion"] as! Bool,
                    isWatched: data["IsWatched"] as! Bool,
                    imdbId: data["ImdbId"] as! String,
                    posterImageURL: data["PosterImageUrl"] as? String
                    )
            }
        }
    }
    
    func getGreatMovieByVolume(volume: Int) {
        db.collection("great_movies").whereField("Volume", isEqualTo: volume).order(by: "Name").addSnapshotListener { snapshot, error in
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
            self.greatMovies = documents.map { snapshot -> GreatMovieModel in
                let data = snapshot.data()
                return GreatMovieModel(
                    id: snapshot.documentID,
                    name: data["Name"] as! String,
                    year: data["Year"] as! Int,
                    volume: data["Volume"] as! Int,
                    director: data["Director"] as! String,
                    isCriterion: data["IsCriterion"] as! Bool,
                    isWatched: data["IsWatched"] as! Bool,
                    imdbId: data["ImdbId"] as! String,
                    posterImageURL: data["PosterImageUrl"] as? String
                )
            }
        }
    }
}
