//
//  Item.swift
//  Grocery List
//
//  Created by Swantan Barua on 27/12/25.
//

// MARK: - IMPORTS
import Foundation
import SwiftData

// MARK: - MODEL
@Model
class Item {
    
    // MARK: - PROPERTIES
    var title: String
    var isCompleted: Bool
    
    // MARK: - INITIALIZATION
    init(
        title: String,
        isCompleted: Bool
    ) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
