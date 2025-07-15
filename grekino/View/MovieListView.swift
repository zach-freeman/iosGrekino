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
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                if viewModel.state.errorMessage != nil {
                    Text(viewModel.state.errorMessage ?? "Unknown Error")
                } else {
                    movieListView()
                }
            }
        }
        .onAppear {
            viewModel.send(action: .didAppear)
        }
    }
    
    @ViewBuilder
    func movieListView() -> some View {
        NavigationView {
            List {
                ForEach(viewModel.state.movies, id: \.id) { greatMovie in
                    VStack(alignment: .leading) {
                        Text(greatMovie.name).font(.headline)
                        Text(greatMovie.director).font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle("Great Movies")
    }
}

#Preview {
    MovieListView(
        viewModel:
            MovieListViewModel(repository: PreviewGreatMovieRepository(), volume: 1),
        listId: .constant(.one)
    )
}
