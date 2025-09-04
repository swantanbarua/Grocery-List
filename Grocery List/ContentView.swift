//
//  ContentView.swift
//  Grocery List
//
//  Created by Swantan Barua on 04/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Query var items: [Item]
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.title)
                }
            }
            .navigationTitle("Grocery List")
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView(
                        "Empty Cart",
                        systemImage: "cart.circle",
                        description: Text("Add some items to the shopping list")
                    )
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview("Sample Data") {
    ContentView()
        .modelContainer(
            for: Item.self,
            inMemory: true
        )
}

#Preview("Empty View") {
    ContentView()
        .modelContainer(
            for: Item.self,
            inMemory: true
        )
}
