//
//  MovieListView.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//
import SwiftUI

struct MovieListView: View {
    @Binding var listId: Int
    var body: some View {
        Text("Movie List View: " + String(listId))
    }
}
