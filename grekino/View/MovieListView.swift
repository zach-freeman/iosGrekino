//
//  MovieListView.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//
import SwiftUI

struct MovieListView: View {
    @StateObject private var firestoreGreatMovieRepository = FirestoreGreatMovieRepository()
    @Binding var listId: Tabs
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(firestoreGreatMovieRepository.greatMovies) { greatMovie in
                        VStack (alignment: .leading) {
                            Text(greatMovie.name).font(.headline)
                            Text(greatMovie.director).font(.subheadline)
                        }
                        
                    }
                }
            }
            .navigationTitle("Great Movies")
            .onAppear {
                firestoreGreatMovieRepository.getGreatMovieByVolume(volume: listId.id)
            }
        }
    }
}
