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
    
    // MARK: - FUNCTIONS
    private func addEssentialFoods() {
        modelContext.insert(
            Item(
                title: "Bakery & Bread",
                isCompleted: .random()
            )
        )
        
        modelContext.insert(
            Item(
                title: "Meat & Seafood",
                isCompleted: .random()
            )
        )
        
        modelContext.insert(
            Item(
                title: "Cereals",
                isCompleted: .random()
            )
        )
        
        modelContext.insert(
            Item(
                title: "Pasta & Rice",
                isCompleted: .random()
            )
        )
        
        modelContext.insert(
            Item(
                title: "Cheese & Eggs",
                isCompleted: .random()
            )
        )
    }
    
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
#Preview {
    ContentView()
        .modelContainer(
            for: Item.self,
            inMemory: true
        )
}
