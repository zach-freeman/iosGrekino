//
//  ContentView.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab){
            Tab("One", systemImage: "1.circle", value: 1) {
                MovieListView(listId: $selectedTab)
            }
            Tab("Two", systemImage: "2.circle", value: 2) {
                MovieListView(listId: $selectedTab)
            }
            Tab("Three", systemImage: "3.circle", value: 3) {
                MovieListView(listId: $selectedTab)
            }
            Tab("Four", systemImage: "4.circle", value: 4) {
                MovieListView(listId: $selectedTab)
            }
        }
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
