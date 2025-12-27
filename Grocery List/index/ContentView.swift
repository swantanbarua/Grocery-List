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
    @Environment(\.modelContext) private var modelContainer
    @Query private var items: [Item]
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: Item.self,
            inMemory: true
        )
}
