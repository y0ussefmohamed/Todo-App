//
//  AddTodoView.swift
//  CoreData Todo
//
//  Created by Youssef Mohamed on 23/03/2024.
//

import SwiftUI

struct AddTaskView: View 
{
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = CoreDataViewModel.shared
    @State var textField: String = ""
    @State var showAlert = false
    
    var body: some View {
        ZStack {
            Color(hue:0.086,saturation: 0.141,brightness: 0.972)
                .ignoresSafeArea(edges: .all)
            VStack {
                HStack {
                    Text("Create a New Task")
                        .foregroundStyle(.black)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                }
                
                TextField("Enter you task here...", text: $textField)
                    .padding(12)
                    .background(.white)
                    .cornerRadius(10)
                    .foregroundStyle(.black)
                    .colorScheme(.light)
                    
                
                Button {
                    if( !textField.isEmpty ) {
                        viewModel.addTask(title: textField)
                        textField = ""
                        dismiss()
                    } else {
                        showAlert = true // Show alert if text field is empty
                    }
                } label: {
                    Text("Add Task")
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color(.systemGreen))
                        .cornerRadius(20)
                }
                .padding()
                Spacer()
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Empty Task"),
                message: Text("Please enter a task before adding."),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}

#Preview {
    AddTaskView()
}
