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
        NavigationSplitView {
            List(viewModel.state.movies) { greatMovie in
                NavigationLink {
                    MovieDetailView(greatMovie: greatMovie)
                } label: {
                    MovieListRowView(greatMovie: greatMovie)
                }
            }
            .navigationTitle("Great Movies Volume \(listId.id)")
        } detail: {
            Text("Select a movie to see more details.")
        }
        
    }
}

#Preview {
    MovieListView(
        viewModel:
            MovieListViewModel(repository: PreviewGreatMovieRepository(), volume: 1),
        listId: .constant(.one)
    )
}
