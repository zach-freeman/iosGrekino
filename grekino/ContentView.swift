//
//  ContentView.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//

import CoreData
import SwiftUI

struct ContentView: View {

    @State private var selectedTab: Tabs = .one

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                Tab(Tabs.one.name, systemImage: Tabs.one.symbol, value: Tabs.one) {
                    MovieListView(
                        repository: FirestoreGreatMovieRepository(), listId: selectedTab
                    )
                }
                Tab(Tabs.two.name, systemImage: Tabs.two.symbol, value: Tabs.two) {
                    MovieListView(
                        repository: FirestoreGreatMovieRepository(), listId: selectedTab
                    )
                }
                Tab(
                    Tabs.three.name,
                    systemImage: Tabs.three.symbol,
                    value: Tabs.three
                ) {
                    MovieListView(
                        repository: FirestoreGreatMovieRepository(), listId: selectedTab
                    )
                }
                Tab(Tabs.four.name, systemImage: Tabs.four.symbol, value: Tabs.four)
                {
                    MovieListView(
                        repository: FirestoreGreatMovieRepository(), listId: selectedTab
                    )
                }
                Tab(
                    Tabs.search.name,
                    systemImage: Tabs.search.symbol,
                    value: Tabs.search
                ) {
                    Text("search")
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(
        \.managedObjectContext,
        PersistenceController.preview.container.viewContext
    )
}
