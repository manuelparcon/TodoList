//
//  ItemModel.swift
//  TodoList
//
//  Created by Manuel Parcon on 9/29/24.
//

// Using Swift template, not SwiftUI

import Foundation

// Immutable Struct
// Remember: If we want to use the struct to a ForEach loop, it must conform to the identifiable protocol.
// Codable - by conforming to this, we can encode and decode into data and out of data
struct ItemModel: Identifiable, Codable {
    // move UUID().uuidString to init below
//    let id: String = UUID().uuidString
    let id: String
    let title: String
    let isCompleted: Bool
    
    // By default this is what the init for ItemModel looks like
//    init(title: String, isCompleted: Bool) {
//        self.id = UUID().uuidString
//        self.title = title
//        self.isCompleted = isCompleted
//    }
    
    // With below, we can give an item an id by initializing it with id, or it can get one automatically if id is not in the parameters when creating one.
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }

}
