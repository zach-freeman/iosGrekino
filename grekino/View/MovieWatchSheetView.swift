//
//  MovieWatchSheetView.swift
//  grekino
//
//  Created by Zach Freeman on 7/24/25.
//

import SwiftUI

struct MovieWatchSheetView: View {
    var greatMovie : GreatMovieDetailModel
    let doneButtonAction : () -> Void
    
    var body : some View {
        VStack(spacing: 10) {
            Text(greatMovie.name)
                .font(Font.ubuntuMedium(type: .bold))
            Text(greatMovie.year.description)
                .font(Font.ubuntuSmall(type: .regular))
            Divider()
            Image(systemName: "eye.fill")
                .font(.title.weight(.semibold))
                .foregroundColor(Color.green)
            Text("Watched")
                .font(Font.ubuntuSmall(type: .regular))
            Divider()
            Text("Rated")
                .font(Font.ubuntuSmall(type: .regular))
            StarRatingView(numberOfStars: greatMovie.starRating?.toInt() ?? 0, color: Color.green, font: .caption.weight(.semibold))
            Divider()
            Spacer()
            Button("Done", action: { doneButtonAction() })
        }
    }
}

#Preview {
    MovieWatchSheetView(greatMovie: PreviewData.getPreviewMovieDetail0(), doneButtonAction: { print("Done")})
}

