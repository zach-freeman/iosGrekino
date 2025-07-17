//
//  MovieListView.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//
import SwiftUI

struct MovieListView: View {
    @State var viewModel: MovieListViewModel
    var listId: Tabs
    
    init(repository: GreatMovieRepositoryProtocol, listId: Tabs) {
        viewModel = MovieListViewModel(repository: repository, volume: listId.id)
        self.listId = listId
    }
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
                    MovieDetailView(
                        greatMovie: greatMovie,
                        viewModel: MovieDetailViewModel(
                            greatMovieRepository:
                                FirestoreGreatMovieRepository(),
                            greatMovieModel: greatMovie
                        )
                    )
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
 MovieListView(repository: PreviewGreatMovieRepository(), listId: .one)
}
