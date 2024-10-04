//
//  ListRowView.swift
//  TodoList
//
//  Created by Manuel Parcon on 9/29/24.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

#Preview {
    let item1 = ItemModel(title: "First item!", isCompleted: false)
    ListRowView(item: item1)
    }
