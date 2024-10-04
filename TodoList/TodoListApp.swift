//
//  TodoListApp.swift
//  TodoList
//
//  Created by Manuel Parcon on 9/29/24.
//

import SwiftUI

/*
 MVVM Architecture
 
 Model - Data point, custom data model.
 View - UI
 ViewModel - Observable objects that manages Models for View. In it are all the logic for creating, reading, updating, and deleting data.
 */

@main
struct TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                // Putting ListView() inside NavigationStack ensures that all Views in our app will be inside the NavigationStack
                ListView()
            }
            // Passing the listViewModel as an environment object using .environmentObject so the entire NavigationStack has access to it, instead of just to the ListView()
            .environmentObject(listViewModel)
        }
    }
}
