//
//  MovieListItem.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

import SwiftUI

struct MovieListRowView: View {
    var greatMovieDetail: GreatMovieDetailModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(greatMovieDetail.name).font(Font.ubuntuLarge(type: .regular))
                Text(greatMovieDetail.director).font(Font.ubuntuMedium(type: .regular))
            }
            Spacer()
            if greatMovieDetail.isWatched {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}

#Preview {
    MovieListRowView(greatMovieDetail: PreviewData.getPreviewMovieDetail0())
}
