//
//  MovieDetailView.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    var greatMovie: GreatMovieModel
    @State private var viewModel: MovieDetailViewModel
    @State private var showingWatchSheet: Bool = false
    
    init(greatMovie: GreatMovieModel, viewModel: MovieDetailViewModel) {
        self.greatMovie = greatMovie
        self.viewModel = MovieDetailViewModel(greatMovieRepository: FirestoreGreatMovieRepository(), greatMovieModel: greatMovie)
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                movieDetailView()
            }
            VStack {
                Spacer()
                Button {
                    showingWatchSheet = true
                } label : {
                    Image(systemName: "eyes")
                      //Add the following modifiers for a circular button.
                      .font(.title.weight(.semibold))
                      .padding()
                      .background(Color.blue)
                      .foregroundColor(.white)
                      .clipShape(Circle())
                }
                .padding(.bottom)
                .actionSheet(isPresented: $showingWatchSheet, content: {
                    ActionSheet(title: Text("I Watched"), message: Text(greatMovie.name), buttons: [
                        .default(Text("OK")) {
                            viewModel.send(action: .didWatchMovie)
                            showingWatchSheet = false
                        },
                        .default(Text("Cancel")) {
                            showingWatchSheet = false
                        }
                    ])
                })
            }

        }
        .padding(.horizontal)
        .onAppear {
            viewModel.send(action: .didAppear)
        }
    }
    
    @ViewBuilder
    func movieDetailView() -> some View {
        VStack {
            movieDetailGridView()
            Text(viewModel.state.description ?? "")
                .font(Font.ubuntuMedium(type: .regular))
            Spacer()
        }
    }
    
    @ViewBuilder
    func movieDetailGridView() -> some View {
        HStack {
            movieDetailLeftSideView()
            Spacer()
            moviedetailRightSideView()
        }
    }
    
    @ViewBuilder
    func movieDetailLeftSideView() -> some View {
        VStack(alignment: .leading) {
            Text(greatMovie.name)
                .font(Font.ubuntuLarge(type: .regular))
                .padding(.bottom, 8)
            Text("\(greatMovie.year.description) | DIRECTED BY")
                .font(Font.ubuntuSmall(type: .regular))
                .padding(.bottom, 4)
            Text(greatMovie.director)
        }
    }
    
    func moviedetailRightSideView() -> some View {
        VStack(alignment: .trailing) {
            if viewModel.state.posterImageUrl == Constants.noImageFound {
                Image(systemName: "photo")
                    .imageScale(.large)
                    .foregroundColor(.gray)
            } else {
                KFImage(URL(string: viewModel.state.posterImageUrl ?? ""))
                    .gridCellColumns(3)
            }
        }
    }
}

#Preview {
    MovieDetailView(
        greatMovie: PreviewData.getPreviewMovie0(),
        viewModel: MovieDetailViewModel(greatMovieRepository: PreviewGreatMovieRepository(), greatMovieModel: PreviewData.getPreviewMovie0())
    )
}
