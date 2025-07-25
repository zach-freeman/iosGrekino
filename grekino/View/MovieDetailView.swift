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
    var greatMovie: GreatMovieDetailModel
    @State private var viewModel: MovieDetailViewModel
    @State private var showingWatchSheet: Bool = false
    @State private var showingWatchInfo: Bool = false
    @Binding var rootIsPresent: Bool

    init(greatMovie: GreatMovieDetailModel, viewModel: MovieDetailViewModel) {
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

            if !greatMovie.isWatched {
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

        }
        .padding(.horizontal)
        .onAppear {
            viewModel.send(action: .didAppear)
        }
        .sheet(isPresented: $showingWatchInfo) {
            MovieWatchSheetView(
                greatMovie: greatMovie,
                doneButtonAction: { showingWatchInfo.toggle() }
            )
            .padding(24)
            .presentationDetents([.fraction(0.35)])
        }

    }

    @ViewBuilder
    func movieDetailView() -> some View {
        VStack {
            movieDetailGridView()
            Text(viewModel.state.description ?? "")
                .font(Font.ubuntuMedium(type: .regular))
                .padding(.bottom, 8)
            if greatMovie.isWatched {
                HStack(alignment: .center) {
                    Text("You watched this movie!")
                        .font(Font.ubuntuSmall(type: .regular))
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                    Spacer()
                    Button(action: {
                        showingWatchInfo.toggle()
                    }) {
                        Label(
                            "View Watch Details",
                            systemImage: "ellipsis.circle"
                        )
                    }
                    .padding(.horizontal, 10)
                    .foregroundStyle(.secondary)
                    .labelStyle(.iconOnly)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.gray.opacity(0.2))
            }
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
        greatMovie: PreviewData.getPreviewMovieDetail0(),
        viewModel: MovieDetailViewModel(
            greatMovieRepository: PreviewGreatMovieRepository(),
            greatMovieModel: PreviewData.getPreviewMovieDetail0()
        )
    )
}
