//
//  ContentView.swift
//  Grocery List
//
//  Created by Swantan Barua on 27/12/25.
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var item = ""
    @FocusState private var isFocused: Bool
    
    let buttonTip = ButtonTip()
    
    // MARK: - INITIALIZATION
    init() {
        try? Tips.configure()
    }
    
    func setupTips() {
        do {
            try Tips.resetDatastore()
            try Tips.configure([
                .displayFrequency(.immediate)
            ])
        } catch {
            
        }
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
                        .foregroundStyle(
                            item.isCompleted ? Color.accentColor : Color.primary
                        )
                        .strikethrough(item.isCompleted)
                        .italic(item.isCompleted)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    modelContext.delete(item)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button(
                                "Done",
                                systemImage: item.isCompleted ? "x.circle" : "checkmark.circle"
                            ) {
                                item.isCompleted.toggle()
                            }
                            .tint(
                                item.isCompleted ? .accentColor: .green
                            )
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
                            Image(systemName: "carrot")
                        }
                        .popoverTip(buttonTip)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12) {
                    TextField(
                        "",
                        text: $item
                    )
                    .textFieldStyle(.roundedBorder)
                    .padding(12)
                    .background(.tertiary)
                    .cornerRadius(12)
                    .font(.title.weight(.light))
                    .focused(isFocused)
                }
                
                Button {
                    guard item.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                        return
                    }
                    modelContext.insert(
                        Item(
                            title: item,
                            isCompleted: false
                        )
                    )
                    item = ""
                    isFocused = false
                } label: {
                    Text("SAVE")
                        .font(.title2.weight(.medium))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.extraLarge)
            }
            .padding()
            .background(.bar)
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
        
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: Item.self,
            inMemory: true
        )
}
