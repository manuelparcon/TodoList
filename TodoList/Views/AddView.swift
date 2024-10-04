//
//  AddView.swift
//  TodoList
//
//  Created by Manuel Parcon on 9/29/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
//    @Environment(\.isPresented) var isPresented
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
        
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.textField)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    saveButtonPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

            }
            .padding()
        }
        .navigationTitle("Add an Item 🖊️")
        .alert(alertTitle, isPresented: $showAlert) {
            
        }
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long. ☹️"
            showAlert.toggle()
            return false
        }
        return true
    }
}

#Preview {
    NavigationStack {
        AddView()
    }
    .environmentObject(ListViewModel())
}
