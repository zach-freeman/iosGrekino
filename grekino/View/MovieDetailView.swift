//
//  MovieDetailView.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

import Kingfisher
import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    var greatMovie: GreatMovieModel
    @State private var viewModel: MovieDetailViewModel
    @State private var showingWatchSheet: Bool = false
    @Binding var rootIsPresent: Bool

    init(greatMovie: GreatMovieModel, viewModel: MovieDetailViewModel) {
        self.greatMovie = greatMovie
        self.viewModel = MovieDetailViewModel(
            greatMovieRepository: FirestoreGreatMovieRepository(),
            greatMovieModel: greatMovie
        )
        _rootIsPresent = .constant(false)
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
                } label: {
                    Image(systemName: "eyes")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.bottom)
                .fullScreenCover(isPresented: $showingWatchSheet) {
                    MovieWatchDataView(greatMovie: greatMovie)
                }
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
            }
        }
    }
}

#Preview {
    MovieDetailView(
        greatMovie: PreviewData.getPreviewMovie0(),
        viewModel: MovieDetailViewModel(
            greatMovieRepository: PreviewGreatMovieRepository(),
            greatMovieModel: PreviewData.getPreviewMovie0()
        )
    )
}
