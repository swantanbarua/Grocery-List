//
//  ContentView.swift
//  Grocery List
//
//  Created by Swantan Barua on 27/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
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
                        .foregroundStyle(
                            item.isCompleted ? Color.accentColor : Color.primary
                        )
                        .strikethrough(item.isCompleted)
                        .italic(item.isCompleted)
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(item)
                            } label: {
                                Label(
                                    "Delete",
                                    systemImage: "trash"
                                )
                            }
                        }
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                if items.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                           addEssentialFoods()
                        } label: {
                            Label(
                                "Essentials",
                                systemImage: "carrot"
                            )
                        }
                    }
                }
            }
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
    
    // MARK: - FUNCTIONS
    private func addEssentialFoods() {
        modelContext.insert(
            Item(
                title: "Bakery & Bread",
                isCompleted: false
            )
        )
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: Item.self,
            inMemory: true
        )
}
