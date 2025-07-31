//
//  StarRatingView.swift
//  grekino
//
//  Created by Zach Freeman on 7/25/25.
//
import SwiftUI

struct StarRatingView: View {
    var numberOfStars: Int
    var color: Color
    var font: Font

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ForEach(0..<numberOfStars, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .font(font)
                    .foregroundColor(color)
            }
            Spacer()
        }
    }
}

#Preview {
    StarRatingView(numberOfStars: 2, color: Color.green, font: .body.weight(.semibold))
}
