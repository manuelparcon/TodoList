//
//  ListViewModel.swift
//  TodoList
//
//  Created by Manuel Parcon on 9/30/24.
//


// Using Swift template, not SwiftUI
import SwiftUI

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 */


@Observable class ListViewModel {
    
    var items: [ItemModel] = [] {
        // didSet is called everytime we change the items array
        didSet {
            // Instead of adding saveItems to functions like getItems() or addItems(), we can just add it using didSet
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    
    // When ListViewModel is called, these are immediately performed when it is initialized
    init() {
        getItems()
    }
    
    func getItems() {
        // Commented lines below are fake todo items we created. Instead of it, we want to get items persisted from UserDefaults.
//        let newItems = [
//            ItemModel(title: "This is the first title!", isCompleted: false),
//            ItemModel(title: "This is the second title!", isCompleted: true),
//            ItemModel(title: "Third!", isCompleted: false)
//        ]
//        
//        // contentsOf is used to append multiple items
//        items.append(contentsOf: newItems)
        
        // data is optional because there is a chance that there is no data in itemsKey
//        guard let data = UserDefaults.standard.data(forKey: itemsKey) else { return }
        // We use [ItemModel].self because it needs the type of data
        // savedItems is also optional
//        guard let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) else { return }
        
        // Combining guard statements above for shoter version
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        // Below line will only continue if guard did not return anything (means no optional data)
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        // This index is the first index wherein an item in the items array has the same id as the id of the item we are looking for, and we know that it's going to be the same item.
        // This index is an optional, so it must be safely unwrapped
        
        // This way is longer
//        if let index = items.firstIndex(where: { (existingItem) -> Bool in
//            return existingItem.id == item.id
//        }) {
//            // else run this code
//        }
        
        // shorter way
        // $0 is just what we are looping on
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            // YSK that using ItemModel like this creates a new item. Jump to ItemModel definition on what we do to avoid it.
//            items[index] = ItemModel(title: item.title, isCompleted: !item.isCompleted)
            
            // Correct way. Handling of updating the itemmodel is in the ItemModel file
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        // Why are we not using App Storage? Because we are in a class. It's better to use UserDefaults
        // UserDefaults has not idea about our item models. Need to convert all itemmodels to JSON data
//        UserDefaults.standard.set(Any?, forKey: String)
        
        // Converting to JSON data needs the ItemModel to conform to Codable
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
        
    }
    
}
