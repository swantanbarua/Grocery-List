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
                        .foregroundColor(
                            item.isCompleted ? .accentColor : .primary
                        )
                        .strikethrough(
                            item.isCompleted,
                            color: .red
                        )
                        .italic(item.isCompleted)
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
    
    let container = try! ModelContainer(
        for: Item.self,
        configurations: ModelConfiguration(
            isStoredInMemoryOnly: true
        )
    )
    
    container.mainContext.insert(
        Item(
            title: "Bakery & Bread",
            isCompleted: false
        )
    )
    
    container.mainContext.insert(
        Item(
            title: "Meat & Seafood",
            isCompleted: true
        )
    )
    
    container.mainContext.insert(
        Item(
            title: "Cereals",
            isCompleted: .random()
        )
    )
    
    container.mainContext.insert(
        Item(
            title: "Pasta & Rice",
            isCompleted: .random()
        )
    )
    
    container.mainContext.insert(
        Item(
            title: "Cheese & Eggs",
            isCompleted: .random()
        )
    )
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty View") {
    ContentView()
        .modelContainer(
            for: Item.self,
            inMemory: true
        )
}
