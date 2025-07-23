//
//  MovieWatchDataView.swift
//  grekino
//
//  Created by Zach Freeman on 7/21/25.
//
import SwiftUI
import Kingfisher

struct MovieWatchDataView: View {
    @Environment(\.dismiss) var dismiss
    var greatMovie: GreatMovieModel
    @State private var viewModel: MovieWatchDataViewModel
    @Binding var rootIsPresented: Bool
    
    init(greatMovie: GreatMovieModel) {
        self.greatMovie = greatMovie
        self.viewModel = MovieWatchDataViewModel(greatMovieModel: greatMovie)
        self._rootIsPresented = .constant(false)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(Font.ubuntuSmall(type: .regular))
                }
                Spacer()
                Text("I Watched...")
                    .font(Font.ubuntuLarge(type: .bold))
                Spacer()
                Button {
                    
                } label : {
                    Text("Save")
                        .font(Font.ubuntuSmall(type: .regular))
                }
            }.padding(.bottom, 10)
            // todo: add review, add movie title, add star rating, add save button, add cancel button
            HStack(alignment: .center) {
                if greatMovie.posterImageURL == Constants.noImageFound {
                    Image(systemName: "photo")
                        .imageScale(.small)
                        .foregroundColor(.gray)
                } else {
                    KFImage(URL(string: greatMovie.posterImageURL ?? ""))
                        .resizable()
                        .frame(width: 45, height: 45)
                }
                Text(greatMovie.name)
                Text("\(greatMovie.year.description)")
                Spacer()
            }
            .frame(width: .infinity, height: 60)
            .background(Color.gray.opacity(0.1))
            HStack {
                Text("Date Watched:")
                    .font(Font.ubuntu(type: Font.FontType.regular, size: Font.FontSize.medium))
                Spacer()
                Text(greatMovie.dateWatched ?? Date().today())
                    .font(Font.ubuntu(type: Font.FontType.regular, size: Font.FontSize.medium))
            }
            .padding(.bottom, 10)
            HStack {
                Text("Rated:")
                    .font(Font.ubuntu(type: Font.FontType.regular, size: Font.FontSize.medium))
                Spacer()
            }
            HStack {
                Button {
                    viewModel.send(action: .didRateOneStar)
                } label: {
                    Image(systemName: "star.fill")
                        .font(.caption.weight(.semibold))
                        .padding()
                        .background(self.viewModel.state.numberOfStars > 0 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                Button {
                    viewModel.send(action: .didRateTwoStars)
                } label: {
                    Image(systemName: "star.fill")
                        .font(.caption.weight(.semibold))
                        .padding()
                        .background(self.viewModel.state.numberOfStars > 1 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                Button {
                    viewModel.send(action: .didRateThreeStars)
                } label: {
                    Image(systemName: "star.fill")
                        .font(.caption.weight(.semibold))
                        .padding()
                        .background(self.viewModel.state.numberOfStars > 2 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                Button {
                    viewModel.send(action: .didRateFourStars)
                } label: {
                    Image(systemName: "star.fill")
                        .font(.caption.weight(.semibold))
                        .padding()
                        .background(self.viewModel.state.numberOfStars > 3 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                Spacer()
            }
            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
 MovieWatchDataView(greatMovie: PreviewData.getPreviewMovie0())
}
