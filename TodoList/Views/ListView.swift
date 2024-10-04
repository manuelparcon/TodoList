//
//  ListView.swift
//  TodoList
//
//  Created by Manuel Parcon on 9/29/24.
//

import SwiftUI

struct ListView: View {
    
    @Environment(ListViewModel.self) var listViewModel: ListViewModel
    
//    @State var items: [ItemModel] = [
//        ItemModel(title: "This is the first title!", isCompleted: false),
//        ItemModel(title: "This is the second title!", isCompleted: true),
//        ItemModel(title: "Third!", isCompleted: false)
//    ]
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    // ForEach data will be the items array
                    // ForEach id will be \.self to give each item a unique ID, unless the variable conforms to identifiable, in which case we don't need to specify an id.
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    // Using onDelete modifier on list allows us to perform actions to the items array
                    // No need for parameters in functions on perform
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                    
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List 📝")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Add") {
                    AddView()
                }
            }
        }
    }
    
//    func deleteItem(indexSet: IndexSet) {
//        items.remove(atOffsets: indexSet)
//    }
//    
//    func moveItem(from: IndexSet, to: Int) {
//        items.move(fromOffsets: from, toOffset: to)
//    }
}

#Preview {
    NavigationStack {
        // Ensure the preview is inside the NavigationStack
        ListView()
    }
    .environment(ListViewModel())
}

