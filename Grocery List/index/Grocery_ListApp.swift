//
//  Grocery_ListApp.swift
//  Grocery List
//
//  Created by Swantan Barua on 27/12/25.
//

// MARK: - IMPORTS
import SwiftUI
import SwiftData

@main
struct Grocery_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
