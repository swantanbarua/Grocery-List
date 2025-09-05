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
                        .font(.title.weight(.light))
                        .padding(
                            .vertical,
                            2
                        )
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
    
    let sampleData = [
        Item(
            title: "Bakery & Bread",
            isCompleted: .random()
        ),
        
        Item(
            title: "Meat & Seafood",
            isCompleted: .random()
        ),
        
        Item(
            title: "Cereals",
            isCompleted: .random()
        ),
        
        Item(
            title: "Pasta & Rice",
            isCompleted: .random()
        ),
        
        Item(
            title: "Cheese & Eggs",
            isCompleted: .random()
        )
    ]
    
    let container = try! ModelContainer(
        for: Item.self,
        configurations: ModelConfiguration(
            isStoredInMemoryOnly: true
        )
    )
    
    for item in sampleData {
        container.modelContext.insert(item)
    }
    
    ContentView()
        .modelContainer(container)
}

#Preview("Empty View") {
    ContentView()
        .modelContainer(
            for: Item.self,
            inMemory: true
        )
}
