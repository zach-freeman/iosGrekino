//
//  MovieListItem.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

import SwiftUI

struct MovieListRowView: View {
    var greatMovie: GreatMovieModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(greatMovie.name).font(Font.ubuntuLarge(type: .regular))
            Text(greatMovie.director).font(Font.ubuntuMedium(type: .regular))
        }
    }
}

#Preview {
    MovieListRowView(greatMovie: PreviewData.getPreviewMovie0())
}
