//
//  MovieDetailView.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

import SwiftUI

struct MovieDetailView: View {
    var greatMovie: GreatMovieModel
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
    }
}

#Preview {
    MovieDetailView(greatMovie: PreviewData.getPreviewMovie0())
}
