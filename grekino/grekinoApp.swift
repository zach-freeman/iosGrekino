//
//  grekinoApp.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//

import SwiftUI
import Firebase

@main
struct grekinoApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
