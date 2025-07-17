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
    
    init(greatMovie: GreatMovieModel, viewModel: MovieDetailViewModel) {
        self.greatMovie = greatMovie
        self.viewModel = MovieDetailViewModel(greatMovieRepository: FirestoreGreatMovieRepository(), greatMovieModel: greatMovie)
    }
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                movieDetailView()
            }
        }
        .onAppear {
            viewModel.send(action: .didAppear)
        }
    }
    
    @ViewBuilder
    func movieDetailView() -> some View {
        movieDetailGridView()
        Text(viewModel.state.description ?? "")
            .font(Font.ubuntuMedium(type: .regular))
        Spacer()
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
