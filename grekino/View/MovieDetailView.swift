//
//  MovieDetailView.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

import SwiftUI

struct MovieDetailView: View {
    var greatMovie: GreatMovieModel
    @ObservedObject var viewModel: MovieDetailViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(greatMovie.name)
                .font(Font.ubuntuLarge(type: .regular))
                .padding(.bottom, 8)
            HStack {
                Text("\(greatMovie.year.description) | DIRECTED BY")
                    .font(Font.ubuntuSmall(type: .regular))
            }
            .padding(.bottom, 4)
            Text(greatMovie.director)
                .font(Font.ubuntuMedium(type: .regular))
            Spacer()
            Text(greatMovie.description ?? "")
                .font(Font.ubuntuMedium(type: .regular))
            Spacer()
        }
        .onAppear {
            viewModel.send(action: .didAppear)
        }
    }
}

#Preview {
    MovieDetailView(
        greatMovie: PreviewData.getPreviewMovie0(),
        viewModel: MovieDetailViewModel(tmdbRepository: TmdbRepository(), greatMovieModel: PreviewData.getPreviewMovie0())
    )
}
