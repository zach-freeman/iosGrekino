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
        self.viewModel = MovieDetailViewModel(tmdbRepository: TmdbRepository(), greatMovieRepository: FirestoreGreatMovieRepository(), greatMovieModel: greatMovie)
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
        Spacer()
        Text(greatMovie.name)
            .font(Font.ubuntuLarge(type: .regular))
            .padding(.bottom, 8)
        HStack {
            Text("\(greatMovie.year.description) | DIRECTED BY")
                .font(Font.ubuntuSmall(type: .regular))
            Spacer()
            KFImage(URL(string: viewModel.state.posterImageUrl ?? ""))
        }
        .padding(.bottom, 4)
        Text(greatMovie.director)
            .font(Font.ubuntuMedium(type: .regular))
        Spacer()
        Text(viewModel.state.description ?? "")
            .font(Font.ubuntuMedium(type: .regular))
        Spacer()
    }
}

#Preview {
    MovieDetailView(
        greatMovie: PreviewData.getPreviewMovie0(),
        viewModel: MovieDetailViewModel(tmdbRepository: TmdbRepository(), greatMovieRepository: PreviewGreatMovieRepository(), greatMovieModel: PreviewData.getPreviewMovie0())
    )
}
