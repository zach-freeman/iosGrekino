//
//  grekinoApp.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//

import SwiftUI
import Firebase

@main
// swiftlint:disable:next type_name
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
