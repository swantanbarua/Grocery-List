//
//  Tip.swift
//  Grocery List
//
//  Created by Swantan Barua on 24/01/26.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
    
    // MARK: - PROPERTIES
    var title = Text("Essential Foods")
    var message = Text("Add some overlay items to the shopping list")
    var image = Image(systemName: "info.circle")
}
