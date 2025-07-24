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
    var greatMovie: GreatMovieDetailModel
    @State private var viewModel: MovieWatchDataViewModel
    @Binding var rootIsPresented: Bool
    @State private var watchDate: Date = Date()
    
    init(greatMovie: GreatMovieDetailModel) {
        self.greatMovie = greatMovie
        self.viewModel = MovieWatchDataViewModel(greatMovieModel: greatMovie)
        self._rootIsPresented = .constant(false)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            headerRow()
            movieInfoRow()
            dateWatchedRow()
            Divider()
            ratedRow()
            ratePickerRow()
            Divider()
            HStack {
                Text(viewModel.state.reviewText.isEmpty ? "Add Review..." : viewModel.state.reviewText)
                    .font(Font.ubuntu(type: Font.FontType.regular, size: Font.FontSize.medium))
                Spacer()
            }
            Spacer()
        }
        .onAppear {
            viewModel.send(action: .didAppear)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func headerRow() -> some View {
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
                viewModel.send(action: .didSave)
                dismiss()
            } label : {
                Text("Save")
                    .font(Font.ubuntuSmall(type: .regular))
            }
        }.padding(.bottom, 10)
    }
    
    @ViewBuilder
    func movieInfoRow() -> some View {
        HStack(alignment: .center) {
            if greatMovie.posterImageUrl == Constants.noImageFound {
                Image(systemName: "photo")
                    .imageScale(.small)
                    .foregroundColor(.gray)
            } else {
                KFImage(URL(string: greatMovie.posterImageUrl ?? ""))
                    .resizable()
                    .frame(width: 45, height: 45)
            }
            Text(greatMovie.name)
                .font(Font.ubuntu(type: Font.FontType.bold, size: Font.FontSize.medium))
            Text("\(greatMovie.year.description)")
                .font(Font.ubuntu(type: Font.FontType.regular, size: Font.FontSize.small))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .background(Color.gray.opacity(0.1))
    }
    
    @ViewBuilder
    func dateWatchedRow() -> some View {
        HStack {
            DatePicker(selection: $watchDate, displayedComponents: .date) {
                Text("Date Watched:")
                    .font(Font.ubuntu(type: Font.FontType.regular, size: Font.FontSize.medium))
            }.onChange(of: watchDate) { oldValue, newValue in
                self.viewModel.setDateWatched(newValue)
                self.viewModel.send(action: .didUpdateDateWatched)
            }
        }
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    func ratedRow() -> some View {
        HStack {
            Text("Rated:")
                .font(Font.ubuntu(type: Font.FontType.regular, size: Font.FontSize.medium))
            Spacer()
        }
    }
    
    @ViewBuilder
    func ratePickerRow() -> some View {
        HStack {
            Button {
                viewModel.send(action: .didRateOneStar)
            } label: {
                Image(systemName: "star.fill")
                    .font(.caption.weight(.semibold))
                    .padding()
                    .background(self.viewModel.state.numberOfStars > 0 ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            Button {
                viewModel.send(action: .didRateTwoStars)
            } label: {
                Image(systemName: "star.fill")
                    .font(.caption.weight(.semibold))
                    .padding()
                    .background(self.viewModel.state.numberOfStars > 1 ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            Button {
                viewModel.send(action: .didRateThreeStars)
            } label: {
                Image(systemName: "star.fill")
                    .font(.caption.weight(.semibold))
                    .padding()
                    .background(self.viewModel.state.numberOfStars > 2 ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            Button {
                viewModel.send(action: .didRateFourStars)
            } label: {
                Image(systemName: "star.fill")
                    .font(.caption.weight(.semibold))
                    .padding()
                    .background(self.viewModel.state.numberOfStars > 3 ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            
            Spacer()
        }
        .padding(.bottom, 10)
    }
}

#Preview {
 MovieWatchDataView(greatMovie: PreviewData.getPreviewMovieDetail0())
}
