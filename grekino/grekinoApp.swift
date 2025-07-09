//
//  grekinoApp.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//

import SwiftUI

@main
struct grekinoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
