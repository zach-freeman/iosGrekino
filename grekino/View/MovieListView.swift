//
//  MovieListView.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//
import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    @Binding var listId: Tabs
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(viewModel.movies) { greatMovie in
                        VStack(alignment: .leading) {
                            Text(greatMovie.name).font(.headline)
                            Text(greatMovie.director).font(.subheadline)
                        }

                    }
                }
            }
            .navigationTitle("Great Movies")
            .onAppear {
                viewModel.loadMoviesForVolume(volume: listId.id)
            }
        }
    }
}

#Preview {
    MovieListView(
        viewModel:
            MovieListViewModel(repository: PreviewGreatMovieRepository()),
        listId: .constant(.one)
    )
}
